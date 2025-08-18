package com.farm.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.farm.config.CustomUserDetails;
import com.farm.dto.AddressDTO;
import com.farm.dto.MemberDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.IMemberService;
import com.farm.service.IMypageService;

@Controller
public class MypageController {
	
	@Autowired
	IMypageService mypageDAO;
	@Autowired
	IMemberService memDAO;
	
	@GetMapping("/mypage.do")
	public String mypageMapper(@AuthenticationPrincipal CustomUserDetails userDetails) {
		MemberDTO member = userDetails.getMemberDTO();
		if(member.getUser_type().equals("ROLE_BUYER")) {
			return "redirect:/buyer/mypage.do";
		}
		else if(member.getUser_type().equals("ROLE_ADMIN")) {
			return "redirect:/admin/mypage.do";
		}
		else {
			return "redirect:/seller/mypage.do";
		}
	}
	
	@GetMapping("/buyer/mypage.do")
	public String buyerMypage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		if(userDetails!=null) {
			MemberDTO member = userDetails.getMemberDTO();
			Long member_id = member.getMember_id();
			int orderCnt = mypageDAO.getOrderCnt(member_id);
			int reviewCnt = mypageDAO.getReviewCnt(member_id);
			int inquiryCnt = mypageDAO.getInquiryCnt(member_id);
			model.addAttribute("member", member);
			model.addAttribute("orderCnt", orderCnt);
			model.addAttribute("reviewCnt", reviewCnt);
			model.addAttribute("inquiryCnt_buyer", inquiryCnt);
		}
		return "buyer/mypage";
	}
	
	
	@GetMapping("/buyer/address/list.do")
	public String buyerAddress(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		
		MemberDTO member = userDetails.getMemberDTO();
		Long member_id = member.getMember_id();
		AddressDTO address = memDAO.selectAddress(member_id);
		
		model.addAttribute("AddressDTO", address);
		model.addAttribute("member", member);
		
		return "buyer/delivery-destination";
	}
	
	@PostMapping("/buyer/address/write.do")
	public ResponseEntity<AddressDTO> addAddress(@RequestBody AddressDTO addressDTO,
				@AuthenticationPrincipal CustomUserDetails userDetails){
		MemberDTO member = userDetails.getMemberDTO();
		Long member_id = member.getMember_id();
		
		addressDTO.setMember_id(member_id);
		int result = memDAO.insertAddress(addressDTO);
		
		return ResponseEntity.ok(addressDTO);
	}
	
	@PostMapping("/buyer/address/update.do")
	public ResponseEntity<Long> updateAddress(@RequestBody Long addr_id,
			@AuthenticationPrincipal CustomUserDetails userDetails){
		MemberDTO member = userDetails.getMemberDTO();
		Long member_id = member.getMember_id();
		
		// 멤버의 모든 address 전체 main 0으로 변경
		int resultZero = memDAO.updateMainToZero(member_id);
		// 메인 지정
		int resultMain = memDAO.updateMain(addr_id);
		
		return ResponseEntity.ok(addr_id);
	}
	
	@GetMapping("/seller/mypage.do")
	public String sellerMypage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		if(userDetails!=null) {
			// 현재 사용자 불러오기
			MemberDTO member = userDetails.getMemberDTO();
			Long member_id = member.getMember_id();
			
			/******  상품 주문 현황  ******/
			int chkOrder = mypageDAO.getCheckOrder(member_id);    // 주문확인중
			int preOrder = mypageDAO.getPrepareOrder(member_id);  // 상품준비중
			int deliOrder = mypageDAO.getDeliOrder(member_id);    // 배송중
			int cmplOrder = mypageDAO.getCompleteOrder(member_id);// 배송완료
			model.addAttribute("member", member);
			model.addAttribute("chkOrder", chkOrder);
			model.addAttribute("preOrder", preOrder);
			model.addAttribute("deliOrder", deliOrder);
			model.addAttribute("cmplOrder", cmplOrder);
			
			/****** 상품문의현황  ******/
			int inquiryCnt = mypageDAO.getInquiryCnt_Seller(member_id); // 현재 문의 수
			model.addAttribute("inquiryCnt_seller", inquiryCnt);
			
			/****** 등록한 상품 목록  ******/
			List<ProductDTO> myProducts = mypageDAO.getMyProducts(member_id); // 모든 항목(현재는 페이징x)
			model.addAttribute("myProducts", myProducts);
			
			/****** 내 상품의 리뷰  ******/
			List<ReviewBoardDTO> myReviews = mypageDAO.getMyReviews(member_id); // 모든 항목(현재는 페이징x)
			model.addAttribute("myReviews", myReviews);
			
		}
		return "seller/seller_myPage";
	}

	@GetMapping("/seller/api/sold-stats")
	@ResponseBody
	public JSONObject sellerSaleData(@RequestParam("memberId") Long member_id){
		/****** 상품판매실적  ******/
		LocalDate today = LocalDate.now();			// 오늘날짜
		LocalDate fourDaysAgo = today.minusDays(4); // 4일전
		
		// sql Date로 변환
		Date sqlToday = Date.valueOf(today);
		Date sqlFourDaysAgo = Date.valueOf(fourDaysAgo);
		
		List<Date> dateList = new ArrayList<>();
		for(int i = 0; i<4; i++) {
			dateList.add(Date.valueOf(today.minusDays(i)));
		}
		
		List<Integer> soldNum = mypageDAO.getSoldNum(member_id, sqlToday, sqlFourDaysAgo); // 지난 5일 판매량
		List<Integer> sales = mypageDAO.getSales(member_id, sqlToday, sqlFourDaysAgo);     // 지난 5일 매출
		
		Map<String, Object> soldData = new HashMap<>();
		
		for(int i = 0; i<5; i++) {
			soldData.put("date",dateList);
			soldData.put("sold",soldNum);
			soldData.put("sales",sales);
		}
		
		JSONObject soldJSON = new JSONObject(soldData);
		
		return soldJSON;
	}
	
	@GetMapping("/buyer/myPageList")
	public String myPageList() {
		return "buyer/myPageList";
	}
	
	@GetMapping("/buyer/member-info")
    public String member_info1() {
        return "buyer/member-info";
    }
	
	
    @GetMapping("/seller/sellerManagement")
    public String sellerManagement() {
        return "seller/sellerManagement"; // /WEB-INF/views/seller/sellerManagement.jsp
    }

    @GetMapping("/seller/monitoring")
    public String monitoring() {
        return "seller/AI";
    }

    @GetMapping("/seller/sellerUpdateForm")
    public String sellerUpdateForm() {
        return "seller/sellerUpdateForm";
    }

    @GetMapping("/seller/reviewManagement")
    public String reviewManagement() {
        return "seller/reviewManagement";
    }
    @GetMapping("/seller/sellermember-info")
    public String member_info() {
        return "seller/sellermember-info";
    }
}

package com.farm.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.MemberDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.IMypageService;

@Controller
public class MypageController {
	
	@Autowired
	IMypageService dao;
	
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
			int orderCnt = dao.getOrderCnt(member_id);
			int reviewCnt = dao.getReviewCnt(member_id);
			int inquiryCnt = dao.getInquiryCnt(member_id);
			model.addAttribute("member", member);
			model.addAttribute("orderCnt", orderCnt);
			model.addAttribute("reviewCnt", reviewCnt);
			model.addAttribute("inquiryCnt_buyer", inquiryCnt);
		}
		return "buyer/mypage";
	}
	@GetMapping("/seller/mypage.do")
	public String sellerMypage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		if(userDetails!=null) {
			// 현재 사용자 불러오기
			MemberDTO member = userDetails.getMemberDTO();
			Long member_id = member.getMember_id();
			
			/******  상품 주문 현황  ******/
			int chkOrder = dao.getCheckOrder(member_id);    // 주문확인중
			int preOrder = dao.getPrepareOrder(member_id);  // 상품준비중
			int deliOrder = dao.getDeliOrder(member_id);    // 배송중
			int cmplOrder = dao.getCompleteOrder(member_id);// 배송완료
			model.addAttribute("member", member);
			model.addAttribute("chkOrder", chkOrder);
			model.addAttribute("preOrder", preOrder);
			model.addAttribute("deliOrder", deliOrder);
			model.addAttribute("cmplOrder", cmplOrder);
			
			/****** 상품문의현황  ******/
			int inquiryCnt = dao.getInquiryCnt_Seller(member_id); // 현재 문의 수
			model.addAttribute("inquiryCnt_seller", inquiryCnt);
			
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
			
			List<Integer> soldNum = dao.getSoldNum(member_id, sqlToday, sqlFourDaysAgo); // 지난 5일 판매량
			List<Integer> sales = dao.getSales(member_id, sqlToday, sqlFourDaysAgo);     // 지난 5일 매출
			
			Map<String, Object> soldData = new HashMap<>();
			
			for(int i = 0; i<5; i++) {
				soldData.put("date",dateList);
				soldData.put("sold",soldNum);
				soldData.put("sales",sales);
			}
			// 날짜별 판매량/매출(지난 5일간)
			// Object로 보내서 list로 변환필요
			model.addAttribute("soldData",soldData);
			
			/****** 등록한 상품 목록  ******/
			List<ProductDTO> myProducts = dao.getMyProducts(member_id); // 모든 항목(현재는 페이징x)
			model.addAttribute("myProducts", myProducts);
			
			/****** 내 상품의 리뷰  ******/
			List<ReviewBoardDTO> myReviews = dao.getMyReviews(member_id); // 모든 항목(현재는 페이징x)
			model.addAttribute("myReviews", myReviews);
			
		}
		return "seller/seller_myPage";
	}

    @GetMapping("/sellerManagement")
    public String sellerManagement() {
        return "seller/sellerManagement"; // /WEB-INF/views/seller/sellerManagement.jsp
    }

    @GetMapping("/productRegistration")
    public String productRegistration() {
        return "seller/productRegistration";
    }

    @GetMapping("/seller/monitoring")
    public String monitoring() {
        return "seller/seller_myPage";
    }

    @GetMapping("/sellerUpdateForm")
    public String sellerUpdateForm() {
        return "seller/sellerUpdateForm";
    }

    @GetMapping("/reviewManagement")
    public String reviewManagement() {
        return "seller/reviewManagement";
    }
	
}

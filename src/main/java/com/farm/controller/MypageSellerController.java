package com.farm.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.farm.config.CustomUserDetails;
import com.farm.dto.MemberDTO;
import com.farm.dto.OrderDTO;
import com.farm.dto.ParameterDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.ReviewBoardDTO;
import com.farm.service.IMemberService;
import com.farm.service.IMypageService;
import com.farm.service.IOrderService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MypageSellerController {
	
	@Value("${board.pageSize}")
	private int pageSize;
	
	@Value("${board.blockPage}")
	private int blockPage;
	
	@Value("${board.bestSize}")
	private int bestSize;
	
	@Autowired
	IMypageService mypageDAO;
	@Autowired
	IMemberService memDAO;
	@Autowired
	IOrderService orderDAO;
	
	@GetMapping("/seller/mypage.do")
	public String sellerMypage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model, ParameterDTO parameterDTO,
							   HttpServletRequest req) {
		if(userDetails!=null) {
			// 현재 사용자 불러오기
			MemberDTO member = userDetails.getMemberDTO();
			Long member_id = member.getMember_id();
			
			model.addAttribute("member", member);
			
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
	public JSONObject sellerSaleData(@AuthenticationPrincipal CustomUserDetails userDetails){
		Long member_id = userDetails.getMemberDTO().getMember_id();
		
		/****** 상품판매실적  ******/
		LocalDate today = LocalDate.now();			// 오늘날짜
		
		List<Date> dateList = new ArrayList<>();
		List<Integer> soldNumList = new ArrayList<>(); // 지난 5일 판매량
		List<Integer> salesList = new ArrayList<>();     // 지난 5일 매출
		for(int i = 0; i<5; i++) {
			dateList.add(Date.valueOf(today.minusDays(i)));
			Integer sales = mypageDAO.getSales(member_id, Date.valueOf(today.minusDays(i)));
			soldNumList.add(mypageDAO.getSoldNum(member_id, Date.valueOf(today.minusDays(i))));
			salesList.add((sales==null)?0:sales);
		}
		
		
		Map<String, Object> soldData = new HashMap<>();
		
		for(int i = 0; i<5; i++) {
			soldData.put("date",dateList);
			soldData.put("sold",soldNumList);
			soldData.put("sales",salesList);
		}
		
		JSONObject soldJSON = new JSONObject(soldData);
		
		return soldJSON;
	}
	
    @GetMapping("/seller/sellerManagement")
    public String sellerManagement(@AuthenticationPrincipal CustomUserDetails userDetails, Model model,
			   HttpServletRequest req) {
    	
    	Long member_id = userDetails.getMemberDTO().getMember_id();
		
		List<OrderDTO> orders = orderDAO.selectSellerOrdersAll(member_id);
		
		model.addAttribute("orderList", orders);
		System.out.println(orders.toString());
		
        return "seller/sellerManagement";
    }
    
    @PostMapping("/seller/nextstate.do")
    @ResponseBody
    public ResponseEntity<Void> nextState(HttpServletRequest req, @RequestParam("purc_id") Long purc_id, @RequestParam("next") String next) {
    	
    	int result = mypageDAO.updateState(purc_id, next);
    	
    	return ResponseEntity.ok().build();
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
    @GetMapping("/seller/member-info")
    public String member_info() {
        return "seller/member-info";
    }
}

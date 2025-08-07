package com.farm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.MemberDTO;
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
			MemberDTO member = userDetails.getMemberDTO();
			Long member_id = member.getMember_id();
			int chkOrder = dao.getCheckOrder(member_id);
			int preOrder = dao.getPrepareOrder(member_id);
			int deliOrder = dao.getDeliOrder(member_id);
			int cmplOrder = dao.getCompleteOrder(member_id);
			int inquiryCnt = dao.getInquiryCnt_Seller(member_id);
			
			model.addAttribute("member", member);
			model.addAttribute("chkOrder", chkOrder);
			model.addAttribute("preOrder", preOrder);
			model.addAttribute("deliOrder", deliOrder);
			model.addAttribute("cmplOrder", cmplOrder);
			model.addAttribute("inquiryCnt_seller", inquiryCnt);
		}
		return "seller/mypage";
	}
}

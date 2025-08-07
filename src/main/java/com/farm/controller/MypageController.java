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
			return "redirect:buyer/mypage.do";
		}
		else {
			return "redirect:seller/mypage.do";
		}
	}
	
	@GetMapping("/buyer/mypage.do")
	public String buyerMypage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		MemberDTO member = userDetails.getMemberDTO();
		
		model.addAttribute("member", member);
		return "buyer/mypage";
	}
	@GetMapping("/seller/mypage.do")
	public String sellerMypage() {
		return "seller/mypage";
	}
}

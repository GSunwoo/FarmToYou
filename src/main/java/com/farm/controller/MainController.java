package com.farm.controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.MemberDTO;

@Controller
public class MainController {

	@GetMapping("/")
	public String main(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		if(userDetails!=null) {
			MemberDTO member = userDetails.getMemberDTO();
			System.out.println(member.getName());
			model.addAttribute("memberName", member.getName());
			System.out.println(userDetails.getMemberDTO().getUser_id());
			
			// buyer가 아니라면 mypage로 리디렉션
			if(!member.getUser_type().equals("ROLE_BUYER")) {
				return "redirect:/mypage.do";
			}	
		}
		return "main";
	}

	
	
}

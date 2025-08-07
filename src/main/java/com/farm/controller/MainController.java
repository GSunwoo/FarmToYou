package com.farm.controller;

import java.security.Principal;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.MemberDTO;

@Controller
public class MainController {

	@GetMapping("/")
	public String main(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
		MemberDTO member = userDetails.getMemberDTO();
		
		model.addAttribute("memberName", member.getName());
		if(userDetails!=null) {
			System.out.println(userDetails.getMemberDTO().getUser_id());
		}
		return "main";
	}

	@RequestMapping("/member/index.do")
	public String mem() {
		return "member";
	}

	// 로그인, 회원가입, 수정, 삭제처럼 민감하거나 데이터 변경이 일어나는 작업은 꼭 POST를 써야함
	// 구매자
	@PostMapping("/buyer.do")
	public String buyer() {
		return "buyer";
	}

	// 판매자
	@PostMapping("/seller.do")
	public String seller() {
		return "seller";
	}

}

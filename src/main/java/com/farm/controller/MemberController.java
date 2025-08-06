package com.farm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.farm.dto.MemberDTO;

@Controller
public class MemberController {

	@GetMapping("/memberForm/seller.do")
	public String memberFormSeller() {
		return "memberFormSeller";
	}
	
	@GetMapping("/memberForm/buyer.do")
	public String memberFormBuyer() {
		return "memberFormBuyer";
	}
	
	@PostMapping("/memberForm/seller/regist.do")
	public String memberRegistSeller(MemberDTO memberDTO) {
		return "redirect:/";
	}
	@PostMapping("/memberForm/buyer/regist.do")
	public String memberRegistBuyer(MemberDTO memberDTO) {
		return "redirect:/";
	}
	
}

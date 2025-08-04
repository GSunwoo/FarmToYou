package com.farm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

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
	
}

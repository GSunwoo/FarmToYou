package com.farm.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.farm.dto.MemberDTO;

@RestController
public class MemberRestController {
	@PostMapping("/memberForm/seller/regist.do")
	public MemberDTO memberRegistSeller(MemberDTO memberDTO) {
		return memberDTO;
	}
	
	@PostMapping("/memberForm/buyer/regist.do")
	public MemberDTO memberRegistBuyer(MemberDTO memberDTO) {
		return memberDTO;
	}
}

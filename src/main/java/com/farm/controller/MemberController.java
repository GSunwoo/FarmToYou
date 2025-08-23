package com.farm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.farm.dto.MemberDTO;
import com.farm.service.IMemberFormService;

@Controller
public class MemberController {

	@Autowired
    private IMemberFormService formDao;
	
	@GetMapping("/memberForm/seller.do") //회원가입 페이지
	public String memberFormSeller() {
		return "seller/seller_register";
	}
	
	@GetMapping("/memberForm/buyer.do")
	public String memberFormBuyer() {
		return "buyer/buyer_register";
	}
	
	@PostMapping("/memberForm/seller.regist.do") // 서브밋 했을때 가입시켜주는
	public String memberRegistSeller(MemberDTO memberDTO) {
		String passwd = PasswordEncoderFactories.createDelegatingPasswordEncoder()
					.encode(memberDTO.getUser_pw());
		memberDTO.setUser_pw(passwd.replace("{bcrypt}", ""));
		formDao.registMember(memberDTO);
		return "redirect:/";
	}
	@PostMapping("/memberForm/buyer.regist.do")
	public String memberRegistBuyer(MemberDTO memberDTO) {
		String passwd = PasswordEncoderFactories.createDelegatingPasswordEncoder()
				.encode(memberDTO.getUser_pw());
		memberDTO.setUser_pw(passwd.replace("{bcrypt}", ""));
		formDao.registMember(memberDTO);
		return "redirect:/";
	}
	
	
	
	
	
	
}

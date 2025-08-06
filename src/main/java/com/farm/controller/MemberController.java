package com.farm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.farm.dto.MemberDTO;
import com.farm.service.IMemberFormService;

@Controller
public class MemberController {

	@Autowired
	IMemberFormService formDao;
	
	@GetMapping("/memberForm/seller.do") //회원가입 페이지
	public String memberFormSeller() {
		return "seller/seller_register";
	}
	
	@GetMapping("/memberForm/buyer.do")
	public String memberFormBuyer() {
		return "buyer/buyer_register";
	}
	
	@PostMapping("/memberForm/seller/regist.do") // 서브밋 했을때 가입시켜주는
	public String memberRegistSeller(MemberDTO memberDTO) {
		/* 트랜젝션으로 묶어줄 예정 */
		formDao.registMember(memberDTO);
		formDao.registAddr(memberDTO);
		formDao.registFarm(memberDTO);
		return "redirect:/";
	}
	@PostMapping("/memberForm/buyer/regist.do")
	public String memberRegistBuyer(MemberDTO memberDTO) {
		/* 트랜젝션으로 묶어줄 예정 */
		formDao.registMember(memberDTO);
		formDao.registAddr(memberDTO);
		return "redirect:/";
	}
	
}

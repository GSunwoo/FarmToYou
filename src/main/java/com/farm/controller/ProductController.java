package com.farm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.farm.dto.MemberDTO;
import com.farm.dto.ProductDTO;

import ch.qos.logback.core.model.Model;

@Controller
public class ProductController {
	
	@GetMapping("/seller/write.do")
	public String sellerWrite() {
		
		return "seller/write";
	}
	@PostMapping("/seller/write.do")
	public String sellerWrite2(MemberDTO memberDTO) {
		
		return "seller";
	}
}

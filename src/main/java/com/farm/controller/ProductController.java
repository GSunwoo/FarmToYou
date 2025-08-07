package com.farm.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.farm.dto.MemberDTO;
import com.farm.dto.ProductDTO;
import com.farm.service.IProductService;



@Controller
public class ProductController {
	
	@Autowired
	IProductService proDao;
	
	@GetMapping("/seller/write.do")
	public String sellerWrite() {
		
		return "seller/write";
	}
	@PostMapping("/seller/write.do")
	public String sellerWrite2(MemberDTO memberDTO) {
		
		return "redirect:/myPageMain";
	}
	
	@GetMapping("/productList.do")
	public String productList(ProductDTO productDTO, Model model) {
		ArrayList<ProductDTO> lists = proDao.selectProduct(productDTO);
		model.addAttribute("lists",  lists);
		return "Productpage";
	}
	
	
	
}

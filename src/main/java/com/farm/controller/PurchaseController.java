package com.farm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PurchaseController {
	
	@GetMapping("/buyer/purchase.do")
	public String purchase() {
		
		return "order_page";
	}
}

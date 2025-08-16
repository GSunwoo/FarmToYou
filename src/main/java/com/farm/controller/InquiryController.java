package com.farm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class InquiryController {
	
	@GetMapping
	public String inquiry () {
		return "";
	}
}

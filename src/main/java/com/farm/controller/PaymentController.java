package com.farm.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.farm.config.login.CustomUserDetails;

@Controller
public class PaymentController {
	
	@Value("${toss.clientKey}")
	private String WIDGET_CLIENT_KEY; // toss 클라이언트 키
	
	@GetMapping("/buyer/pay/checkout")
	public String checkout(Model model, @AuthenticationPrincipal CustomUserDetails userDetails) {
		model.addAttribute("widgetClientKey",WIDGET_CLIENT_KEY);
		// customerKey를 만들기위해 member_id와 user_id를 Bcrypt로 인코딩 후 model객체로 전달
		Long memberId = userDetails.getMemberDTO().getMember_id();
		String userId = userDetails.getUsername();
		String encoId = PasswordEncoderFactories.createDelegatingPasswordEncoder()
				.encode(memberId.toString()+userId);
		model.addAttribute("customerKey",encoId.replace("{bcrypt}", ""));
		return "checkout";
	}
	
	@GetMapping("/buyer/pay/success")
	public String success() {
		return "success";
	}
	
	@GetMapping("/buyer/pay/fail")
	public String fail() {
		return "fail";
	}
}

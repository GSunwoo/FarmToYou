package com.farm.controller;

import java.util.Random;

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
	
	@GetMapping("/buyer/pay/checkout.do")
	public String checkout(Model model, @AuthenticationPrincipal CustomUserDetails userDetails) {
		model.addAttribute("widgetClientKey",WIDGET_CLIENT_KEY);
		// customerKey를 만들기위해 member_id와 user_id를 Bcrypt로 인코딩 후 model객체로 전달
		Long memberId = userDetails.getMemberDTO().getMember_id();
		String userId = userDetails.getUsername();
		// customerKey 제작
		String encoId = generateRandomString(memberId.toString()+userId,20);
		model.addAttribute("customerKey", encoId);
		return "pay/checkout";
	}
	
	@GetMapping("/buyer/pay/success.do")
	public String success() {
		return "pay/success";
	}
	
	@GetMapping("/buyer/pay/fail.do")
	public String fail() {
		return "pay/fail";
	}
	
	public static String generateRandomString(String input, int length) {
        // 입력값의 해시코드를 시드로 사용
        long seed = input.hashCode();
        Random random = new Random(seed);

        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < length; i++) {
            int idx = random.nextInt(chars.length());
            sb.append(chars.charAt(idx));
        }

        return sb.toString();
    }
}

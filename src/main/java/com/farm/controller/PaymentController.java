package com.farm.controller;

import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.PayDTO;
import com.farm.service.IPayService;

@Controller
public class PaymentController {
	
	@Autowired
	IPayService payDAO;
	
	@Value("${toss.clientKey}")
	private String WIDGET_CLIENT_KEY; // toss 클라이언트 키
	
	@GetMapping("/buyer/pay/checkout.do")
	public String checkout(Model model, @AuthenticationPrincipal CustomUserDetails userDetails, @RequestParam("prod_id") Long prod_id) {
		// 클라이언트키 전달
		model.addAttribute("widgetClientKey",WIDGET_CLIENT_KEY);
		// customerKey를 만들기위해 member_id와 user_id를 Bcrypt로 인코딩 후 model객체로 전달
		Long memberId = userDetails.getMemberDTO().getMember_id();
		String userId = userDetails.getUsername();
		// customerKey 제작 및 전달
		String encoId = generateRandomString(memberId.toString()+userId,20);
		model.addAttribute("customerKey", encoId);
		
		// 주문정보 가공 및 전달
		PayDTO payDTO_Mem = payDAO.getOrderInfoMember(memberId); // 구매자정보
		PayDTO payDTO_Prod = payDAO.getOrderInfoProduct(prod_id); // 상품정보
		PayDTO payDTO = new PayDTO(); // 두 정보를 모두 담을 DTO객체
		// 두가지 정보 합치기
		payDTO.setMember_id(memberId);
		payDTO.setName(payDTO_Mem.getName());
		payDTO.setPhone_num(payDTO_Mem.getPhone_num());
		payDTO.setEmailid(payDTO_Mem.getEmailid());
		payDTO.setEmaildomain(payDTO_Mem.getEmaildomain());
		payDTO.setProd_id(prod_id);
		payDTO.setProd_name(payDTO_Prod.getProd_name());
		payDTO.setProd_price(payDTO_Prod.getProd_price());
		
		LocalDate now = LocalDate.now();
		String nowTime = now.toString();
		String orderId = payDTO.getProd_id().toString() + payDTO.getMember_id().toString() + nowTime;
		String encOrderId = generateRandomString(orderId, 20);
		
		Map<String, String> orderInfo = new HashMap<>();
		orderInfo.put("orderId", encOrderId);
		orderInfo.put("orderName", payDTO.getProd_name());
		orderInfo.put("successUrl", "/buyer/pay/success.do");
		orderInfo.put("failUrl", "/buyer/pay/fail.do");
		orderInfo.put("customerEmail", payDTO.getEmailid()+"@"+payDTO.getEmaildomain());
		orderInfo.put("customerName", payDTO.getName());
		orderInfo.put("customerMobilePhone", payDTO.getPhone_num());
		

		// JSON으로 변환
		JSONObject orderInfoJSON = new JSONObject(orderInfo);
		// 주문정보 전달
		model.addAttribute("orderInfo",orderInfoJSON);
		// 가격 전달
//		model.addAttribute("amount", payDTO.getProd_price());
		model.addAttribute("amount", 1000);
		
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

package com.farm.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
	public String checkout(Model model, @AuthenticationPrincipal CustomUserDetails userDetails,
							@RequestParam("orderName") String orderName, @RequestParam("totalPrice") int totalPrice) {
		// 클라이언트키 전달
		model.addAttribute("widgetClientKey",WIDGET_CLIENT_KEY);
		// member_id와 user_id를 seed로 customerKey를 생성하여 model객체로 전달
		Long memberId = userDetails.getMemberDTO().getMember_id();
		String userId = userDetails.getUsername();
		// customerKey 제작 및 전달
		String encoId = generateRandomString(memberId.toString()+userId,20);
		model.addAttribute("customerKey", encoId);
		
		// 주문정보 가공 및 전달
		PayDTO payDTO = payDAO.getOrderInfoMember(memberId); // 구매자정보 가져오기
		payDTO.setMember_id(memberId);
		// 파라미터로 받은 주문정보
		payDTO.setProd_name(orderName);
		payDTO.setProd_price(totalPrice);
		
		// 주문명과 회원번호, 현재시간을 seed로 주문번호 생성
		LocalDateTime now = LocalDateTime.now();
		String nowTime = now.toString();
		String orderId = payDTO.getProd_name() + payDTO.getMember_id().toString() + nowTime;
		String encOrderId = generateRandomString(orderId, 20);
		
		// toss payments API 형식에 맞춰 Map 생성
		Map<String, String> orderInfo = new HashMap<>();
		orderInfo.put("orderId", encOrderId);     // 주문번호
		orderInfo.put("orderName", payDTO.getProd_name()); // 주문이름
		orderInfo.put("successUrl", "/buyer/pay/success.do"); // 성공 url
		orderInfo.put("failUrl", "/buyer/pay/fail.do"); 	  // 실패 url
		orderInfo.put("customerEmail", payDTO.getEmailid()+"@"+payDTO.getEmaildomain()); // email
		orderInfo.put("customerName", payDTO.getName()); // 구매자명
		orderInfo.put("customerMobilePhone", payDTO.getPhone_num()); // 구매자 핸드폰번호
		
		// 생성한 Map을 JSON으로 변환(js에서 JSON으로 사용)
		JSONObject orderInfoJSON = new JSONObject(orderInfo);
		// 주문정보 전달
		model.addAttribute("orderInfo",orderInfoJSON);
		// 가격 전달
		model.addAttribute("amount", payDTO.getProd_price());
		
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

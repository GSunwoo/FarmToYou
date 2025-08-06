package com.farm.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@GetMapping("/")
	public String main() {
		return "main";
	}

	@RequestMapping("/member/index.do")
	public String mem() {
		return "member";
	}

	// 로그인, 회원가입, 수정, 삭제처럼 민감하거나 데이터 변경이 일어나는 작업은 꼭 POST를 써야함
	// 구매자
	@PostMapping("/buyer.do")
	public String buyer() {
		return "buyer";
	}

	// 판매자
	@PostMapping("/seller.do")
	public String seller() {
		return "seller";
	}

	@RequestMapping("/myLogin.do")
	public String login1(Principal principal, Model model) {
		try {
			String user_id = principal.getName();
			model.addAttribute("user_id", user_id);
		} catch (Exception e) {
			/*
			 * 최초 접근시 로그인 정보가 없으므로 NullPointerException이 발생된다. 따라서 예외처리 해야한다.
			 */
			System.out.println("로그인 전입니다");
		}
		return "auth/login";
	}

	// 로그인 시도 중 에러가 발생하는 경우
	@RequestMapping("/myError.do")
	public String login2() {
		return "exception/error";
	}

	// 권한이 부족한 경우
	@RequestMapping("/denied.do")
	public String login3() {
		return "exception/denied";
	}

}

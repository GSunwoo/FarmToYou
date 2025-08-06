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

}

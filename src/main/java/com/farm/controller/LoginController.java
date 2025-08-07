package com.farm.controller;

import java.security.Principal;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.farm.config.login.CustomUserDetails;
import com.farm.dto.MemberDTO;

@Controller
public class LoginController {
	
	@RequestMapping("/myLogin.do")
	public String login0() {
		return "login";
	}
	
	@RequestMapping("/findPw.do")
	public String login4() {
		return "findPw";
	}

//	  // 이 부분을 추가
//    @PostMapping("/myLoginAction.do")
//    public String loginAction() {
//        // Spring Security가 처리하므로 실제로는 도달하지 않음
//        return "redirect:/";
//    }
	
	
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

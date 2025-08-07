package com.farm.handler;

import java.io.IOException;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@Configuration
@Component
public class LoginHandler implements AuthenticationFailureHandler {
	
	
	@Override
	public void onAuthenticationFailure(
			HttpServletRequest request, 
			HttpServletResponse response,
			AuthenticationException exception) 
					throws IOException, ServletException {
		
		System.out.println("로그인 실패시 여기로 옵니당");
		
		String errorMsg = "";
		
		//instanceof를 사용해서 BadCredentialsException 타입의 예외가
		//살제로 어떤 예외인지 확인하는 코드
		//BadCredentialsException -> 아이디 또는 비밀번호 틀림
		if(exception instanceof BadCredentialsException) {
			//loginFailureCnt -> 사용자가 로그인에 실패했을 때, 해당 사용자의 실패
			//횟수를 증가 시키는 함수
			loginFailureCnt(request.getParameter("my_id"));
		    errorMsg = "아이디나 비밀번호가 맞지 않습니다.(1)";
		}
		else if(exception instanceof InternalAuthenticationServiceException) {
			loginFailureCnt(request.getParameter("my_id"));
			errorMsg = "아이디나 비밀번호가 맞지 않습니다.(2)";
		}
		else if(exception instanceof DisabledException) {
			errorMsg = "계정이 비활성화되었습니다.관리자에게 문의하세요.(3)";
		}
		else if (exception instanceof CredentialsExpiredException) {
			errorMsg = "비밀번호 유효기간이 만료 되었습니다."
					+ "관리자에게 문의하세요.(4)";
		}
		//에러 메세지를 request에 담고 그걸 로그인 페이지로 이동시킴
		//setAttribute -> 요청 범위에 데이터를 담는 함수
		request.setAttribute("errorMsg", errorMsg);
		request.getRequestDispatcher("/myLogin.do?error")
			.forward(request, response);
	}
	
	//loginFailureCnt 메서드 선언
	public void loginFailureCnt(String my_id) {
		System.out.println("요청 아이디: " + my_id);
	}
}
	
	


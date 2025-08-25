package com.farm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.farm.dto.MailInfoDTO;
import com.farm.dto.PassFindDTO;
import com.farm.etc.PassFindMail;
import com.farm.etc.RandomPasswordGenerator;
import com.farm.service.IPassFinderService;

import jakarta.servlet.http.HttpServletRequest;

//로그인 페이지 이동, 권한/에러 페이지 이동, "비밀번호 찾기"처리
@Controller
public class LoginController {
	
	@Autowired
	IPassFinderService passDAO;
	
	@RequestMapping("/myLogin.do")
	public String login0() {
		return "login";
	}
	
	@GetMapping("/guest/findPw.do")
	public String login4() {
		return "findPw";
	}
	
	@Autowired
	PassFindMail findPw;
	
	@PostMapping("/guest/findPw.do")
	public String findPwPost(HttpServletRequest req, RedirectAttributes redirectAttrs) {
		String user_id = req.getParameter("user_id");
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String[] email_sp = email.split("@");
		
		PassFindDTO passDTO = new PassFindDTO();
		
		passDTO.setUser_id(user_id);
		passDTO.setName(name);
		passDTO.setEmailid(email_sp[0]);
		passDTO.setEmaildomain(email_sp[1]);
		
		Long finding_member = passDAO.findUser(passDTO);
		String errorMsg = "";
		if(finding_member!=null) {
			MailInfoDTO mailInfoDTO = new MailInfoDTO();
			// 메일 받을 주소
			mailInfoDTO.setTo(email);
			// 메일 제목 지정
			mailInfoDTO.setSubject("[Farm To You] 새로운 비밀번호가 발급되었습니다.");
			// 새로운 비밀번호 발급 및 인코딩
			String newPw = RandomPasswordGenerator.generatePass(12);
			// Bcrypt로 인코딩
			String passwd = PasswordEncoderFactories.createDelegatingPasswordEncoder()
					.encode(newPw);
			// {bcrypt}제거
			passwd = passwd.replace("{bcrypt}", "");
			
			// 인코딩되기 전의 플레인 텍스트 전송
			mailInfoDTO.setContent(newPw);
			
			System.out.println("플레인 텍스트 : "+newPw);
			System.out.println("인코딩 텍스트 : " + passwd);
			findPw.newPassSender(mailInfoDTO);
			passDAO.sendNewPw(finding_member, passwd);
		}
		else {
			errorMsg="해당 정보를 가진 사용자가 없습니다.";
			redirectAttrs.addAttribute("errorMsg", errorMsg);
			
			return "redirect:/guest/findPw.do";
		}
		return "redirect:/myLogin.do";
	}

//	  // 이 부분을 추가
//    @PostMapping("/myLoginAction.do")
//    public String loginAction() {
//        // Spring Security가 처리하므로 실제로는 도달하지 않음
//        return "redirect:/";
//    }
	
	
	// 로그인 시도 중 에러가 발생하는 경우
	@RequestMapping("/guest/myError.do")
	public String login2() {
		return "exception/error";
	}

	// 권한이 부족한 경우
	@RequestMapping("/guest/denied.do")
	public String login3() {
		return "exception/denied";
	}
}

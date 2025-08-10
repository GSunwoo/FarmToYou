package com.farm.etc;

import java.io.BufferedReader;
import java.io.FileReader;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.util.ResourceUtils;

import com.farm.dto.MailInfoDTO;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class PassFindMail {
	private final JavaMailSender mailSender;

	/*
	 * 보내는 사람의 이메일주소를 프로퍼티 파일로부터 얻어온 후 설정. Naver SMTP를 사용하므로 네이버 메일로 설정해야한다.
	 */
	@Value("${spring.mail.username}")
	private String from;

	public void newPassSender(MailInfoDTO mailInfoDTO) {
		try {
			// 메일을 보내기 위한 설정을 담당
			MimeMessage m = mailSender.createMimeMessage();
			// 인코딩 설정
			MimeMessageHelper h = new MimeMessageHelper(m, "UTF-8");
			// 보내는 사람
			h.setFrom(from);
			// 받는 사람
			h.setTo(mailInfoDTO.getTo());
			// 제목
			h.setSubject(mailInfoDTO.getSubject());
			
			String mailContent = "새로운 비밀번호는 " + mailInfoDTO.getContent();
			h.setText(mailContent);
			
			// 메일 발송
			mailSender.send(m);
			System.out.println("메일 전송 완료..!!");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

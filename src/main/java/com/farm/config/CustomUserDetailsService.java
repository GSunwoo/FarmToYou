package com.farm.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.farm.dto.MemberDTO;
import com.farm.service.IMemberService;

@Service
public class CustomUserDetailsService implements UserDetailsService{
	
	@Autowired
	private IMemberService dao; // Mybatis 매퍼 인터페이스
	
	/*
	username : 로그인 시 입력받은 user_id
	 */
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		//DB에서 user_id로 회원 정보 조회
		MemberDTO memberDTO = dao.loginCheck(username);
		
		if (memberDTO == null) {
			throw new UsernameNotFoundException("유저를 찾을수 없습니다." + username); 
		}
		if(memberDTO.getUser_type().equals("ROLE_BUYER")) {
			memberDTO = dao.selectBuyerData(memberDTO);
		}
		else if(memberDTO.getUser_type().equals("ROLE_SELLER")) {
			memberDTO = dao.selectSellerData(memberDTO);
		}
		
		// 조회된 DTO를 CustomUserDetails에 담아 반환
		return new CustomUserDetails(memberDTO);
	}
}

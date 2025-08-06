package com.farm.config.login;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.farm.dto.MemberDTO;

/*
스프링 시큐리티에서 사용자 정보를 담는 객체
유저디테일 인터페이스 구현.
멤버DTO 전체를 내부에 보관해 로그인 후 필요한 정보 즉시 사용 가능
 */
public class CustomUserDetails implements UserDetails{
	
	private final MemberDTO memberDTO;

	public CustomUserDetails(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of(new SimpleGrantedAuthority("ROLE_"+memberDTO.getUser_type()));
	}
	
	@Override
	public String getPassword() {
		return memberDTO.getUser_pw();
	}
	
	@Override
	public String getUsername() {
		return memberDTO.getUser_id();
	}
	
}

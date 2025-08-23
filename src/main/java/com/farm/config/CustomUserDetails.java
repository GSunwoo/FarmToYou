package com.farm.config;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.farm.dto.MemberDTO;

public class CustomUserDetails implements UserDetails {

	private final MemberDTO memberDTO;

	public CustomUserDetails(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}

	@Override
	public List<GrantedAuthority> getAuthorities() {
		return List.of(new SimpleGrantedAuthority(memberDTO.getUser_type()));
	}

	@Override
	public String getPassword() {
		return memberDTO.getUser_pw();
	}

	@Override
	public String getUsername() {
		return memberDTO.getUser_id();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return memberDTO.getEnable() == 1;
	}

	public MemberDTO getMemberDTO() {
		return memberDTO;
	}
}

package com.farm.service;

import org.apache.ibatis.annotations.Mapper;

import com.farm.dto.MemberDTO;

@Mapper
public interface IMemberFormService {
	// 회원가입
	public int registMember(MemberDTO memberDTO);
	public int registAddr(MemberDTO memberDTO);
	public int registFarm(MemberDTO memberDTO);
	
	public int updateMember(MemberDTO memberDTO);
}

package com.farm.service;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.AddressDTO;
import com.farm.dto.MemberDTO;

@Mapper
public interface IMemberService {

	MemberDTO loginCheck(String userId);
	// user_id로 회원 정보를 조회하는 쿼리
	MemberDTO selectBuyerData (MemberDTO memberDTO);
	MemberDTO selectSellerData (MemberDTO memberDTO);
	
	AddressDTO selectAddress(@Param("member_id") Long member_id);

}

package com.farm.service;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.AddressDTO;
import com.farm.dto.MemberDTO;

@Mapper
public interface IMemberService {

	public MemberDTO loginCheck(String userId);
	// user_id로 회원 정보를 조회하는 쿼리
	public MemberDTO selectBuyerData (MemberDTO memberDTO);
	public MemberDTO selectSellerData (MemberDTO memberDTO);
	
	public AddressDTO selectAddress(@Param("member_id") Long member_id);
	public int insertAddress(AddressDTO addressDTO);
	public int updateMainToZero(@Param("member_id") Long member_id);
	public int updateMain(@Param("addr_id") Long addr_id);

}

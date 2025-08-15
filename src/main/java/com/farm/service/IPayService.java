package com.farm.service;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.PayDTO;

@Mapper
public interface IPayService {
	public PayDTO getOrderInfoMember(@Param("member_id") Long member_id);
	public PayDTO getOrderInfoProduct(@Param("prod_id") Long prod_id);
	public int insertOrder(PayDTO payDTO);
}

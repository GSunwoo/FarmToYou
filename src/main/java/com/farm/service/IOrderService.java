package com.farm.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.OrderDTO;
import com.farm.dto.ParameterDTO;

@Mapper
public interface IOrderService {
	public List<OrderDTO> selectBuyerOrdersAll(@Param("param") ParameterDTO parameterDTO,
											@Param("member_id") Long member_id);
	public List<OrderDTO> selectSellerOrdersAll(@Param("member_id") Long member_id);
}

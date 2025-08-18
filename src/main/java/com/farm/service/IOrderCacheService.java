package com.farm.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.OrderCacheDTO;

@Mapper
public interface IOrderCacheService {
	public int insertOrderCache(OrderCacheDTO orderCacheDTO);
	public int deleteOrderCache(@Param("order_num") String order_num);
	public List<OrderCacheDTO> selectOrderCache(@Param("order_num") String order_num);
}

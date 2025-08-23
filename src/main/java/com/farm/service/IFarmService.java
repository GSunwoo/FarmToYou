package com.farm.service;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.FarmDTO;

@Mapper
public interface IFarmService {
	
	public FarmDTO selectFarmInfo(@Param("member_id") Long member_id);
	
	public void deleteFarm(@Param("member_id") Long member_id);
	
	public int insertFarm(FarmDTO farmDTO);
}

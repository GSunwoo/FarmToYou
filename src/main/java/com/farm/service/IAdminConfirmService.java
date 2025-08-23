package com.farm.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.FarmDTO;
import com.farm.dto.ProductDTO;

@Mapper
public interface IAdminConfirmService {
	// 요청중인 상품 불러오기 및 승인/반려
	public List<ProductDTO> selectRequestProducts();
	public int confirmProduct(@Param("prod_id") Long prod_id);
	public int rejectProduct(@Param("prod_id") Long prod_id);
	
	// 요청중인 농장 불러오기 및 승인/반려
	public List<FarmDTO> selectRequestFarms();
	public int confirmFarm(@Param("farm_id") Long farm_id);
	public int rejectFarm(@Param("farm_id") Long farm_id);
	
	// 계정 활성화/비활성화
	public int enableMember(@Param("member_id") Long member_id);
	public int disableMember(@Param("member_id") Long member_id);
}

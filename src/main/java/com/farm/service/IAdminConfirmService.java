package com.farm.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.FarmDTO;
import com.farm.dto.ProductDTO;

@Mapper
public interface IAdminConfirmService {
	public List<ProductDTO> selectRequestProducts();
	public int confirmProduct(@Param("prod_id") Long prod_id);
	public int rejectProduct(@Param("prod_id") Long prod_id);
	
	public List<FarmDTO> selectRequestFarms();
	public int confirmFarm(@Param("farm_id") Long farm_id);
	public int rejectFarm(@Param("farm_id") Long farm_id);
}

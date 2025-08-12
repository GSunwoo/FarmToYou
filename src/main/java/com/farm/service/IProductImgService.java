package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.ProductImgDTO;

@Mapper
public interface IProductImgService {
	public int insertImg(ProductImgDTO productImgDTO);
	public ArrayList<ProductImgDTO> selectImg(@Param("prod_id") Long prod_id);
	public int deleteImg(@Param("prod_id") Long prod_id);
}

package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.ProductImgDTO;

@Mapper
public interface IProductImgService {
	public int insertImg(ProductImgDTO productImgDTO);
	public ArrayList<ProductImgDTO> selectImg(@Param("prod_id") Long prod_id);
	public ArrayList<ProductImgDTO> selectAllImg(@Param("prod_id") Long prod_id);
	public ProductImgDTO selectMain(@Param("prod_id") Long prod_id);
	public int deleteImg(@Param("prod_id") Long prod_id, @Param("idx") Long idx);
	public int deleteAllImg(@Param("prod_id") Long prod_id);
	
	//메인이미지 변경 메서드
	public int makeZero(@Param("prod_id")Long prod_id);
	public int updateMainImg(@Param("prod_id")Long prod_id,@Param("main_idx") Long main_idx);
	
}

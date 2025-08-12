package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.farm.dto.ProductImgDTO;

@Mapper
public interface IProductImgService {
	public int insertImg(ProductImgDTO productImgDTO);
	public ArrayList<ProductImgDTO> selectImg(ProductImgDTO productImgDTO);
	public int deleteImg(ProductImgDTO productImgDTO);
}

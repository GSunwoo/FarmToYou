package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.ParameterDTO;
import com.farm.dto.ProductDTO;

@Mapper
public interface IProductService {
	
	public int productWrite(ProductDTO productDTO);
	public ProductDTO selectProductView(@Param("prod_id") Long prod_id);
	public int getTotalCount(ParameterDTO parameterDTO);
	
	public ArrayList<ProductDTO> selectMyprod(@Param("member_id") Long member_id);
	public ArrayList<ProductDTO> selectProduct(ParameterDTO parameterDTO);
	public ArrayList<ProductDTO> selectBestProd(ParameterDTO parameterDTO);
	public ArrayList<ProductDTO> selectBestProdForLastWeek(@Param("end") Long end);
	public Long selectMember_id(@Param("prod_id") Long prod_id);
	
	public int productUpdate(ProductDTO productDTO);
	public int productDelete(@Param("prod_id") Long prod_id);

}

package com.farm.service;

import org.apache.ibatis.annotations.Mapper;

import com.farm.dto.ProductDTO;

@Mapper
public interface IProductService {
	
	public int productWrite(ProductDTO productDTO);
	public ProductDTO selectProductView(ProductDTO productDTO);
	public ProductDTO selectProduct(ProductDTO productDTO);
	public int productUpdate(ProductDTO productDTO);
	public int productDelete(ProductDTO productDTO);
}

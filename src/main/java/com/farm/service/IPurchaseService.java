package com.farm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.PurchaseDTO;
import com.farm.dto.WishlistDTO;

@Mapper
public interface IPurchaseService {
	public WishlistDTO selectProduct(@Param("prod_id") String prod_id);
	public List<WishlistDTO> selectProducts(@Param("wish_ids") List<Long> wish_ids);
	public int insertPurchase(PurchaseDTO purchaseDTO);
	
	public int insertPurchaseDummy(@Param("arr") List<PurchaseDTO> arr);
	
	public int updateQty(@Param("prod_id") Long prod_id,
						 @Param("qty") int qty);
}

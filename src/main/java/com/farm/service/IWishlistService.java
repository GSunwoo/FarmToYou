package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.WishlistDTO;

@Mapper
public interface IWishlistService {

	public int addWishlist(WishlistDTO wishlistDTO);
	public ArrayList<WishlistDTO> selectWishlist(@Param("member_id") Long member_id);
	public int updateWishlist(@Param("prod_qty") Long prod_qty, @Param("wish_id") Long wish_id);
	public int deleteWishlist(@Param("wish_id") Long wish_id);
}

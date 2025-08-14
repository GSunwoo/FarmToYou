package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.WishlistDTO;

@Mapper
public interface IWishlistService {

	public int addWishlist(WishlistDTO wishlistDTO);
	public ArrayList<WishlistDTO> selectWishlist(@Param("member_id") Long member_id);
}

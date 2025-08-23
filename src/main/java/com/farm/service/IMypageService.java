package com.farm.service;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.FarmDTO;
import com.farm.dto.ProductDTO;
import com.farm.dto.ReviewBoardDTO;

@Mapper
public interface IMypageService {
	// 구매자용
	public int getOrderCnt(@Param("member_id") Long member_id); // 주문수
	public int getReviewCnt(@Param("member_id")Long member_id); // 리뷰수
	public int getInquiryCnt(@Param("member_id") Long member_id); // 문의수
	
	// 판매자용
	public int getInquiryCnt_Seller(@Param("member_id") Long member_id); // 문의수(판매자)
	// 지난 5일간 총판매량
	public Integer getSoldNum(@Param("member_id") Long member_id,
						@Param("date") Date date);
	// 지난 5일간 총매출
	public Integer getSales(@Param("member_id") Long member_id,
						@Param("date") Date date);
	
	public List<ProductDTO> getMyProducts(@Param("member_id") Long member_id);
	public List<ReviewBoardDTO> getMyReviews(@Param("member_id") Long member_id);
	
	public int updateState(@Param("purc_id") Long purc_id,
						   @Param("next") String next);		
	
	
}

package com.farm.service;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.ProductDTO;
import com.farm.dto.ReviewBoardDTO;

@Mapper
public interface IMypageService {
	// 구매자용
	public int getOrderCnt(@Param("member_id") Long member_id); // 주문수
	public int getReviewCnt(@Param("member_id")Long member_id); // 리뷰수
	public int getInquiryCnt(@Param("member_id") Long member_id); // 문의수
	
	// 판매자용
	public int getCheckOrder(@Param("member_id") Long member_id); // 주문확인중
	public int getPrepareOrder(@Param("member_id") Long member_id); // 상품준비중
	public int getDeliOrder(@Param("member_id") Long member_id); // 배송중
	public int getCompleteOrder(@Param("member_id") Long member_id); // 배송완료
	public int getInquiryCnt_Seller(@Param("member_id") Long member_id); // 문의수(판매자)
	// 지난 5일간 총판매량
	public List<Integer> getSoldNum(@Param("member_id") Long member_id,
						@Param("start_date") Date start_date,
						@Param("end_date")	Date end_date);
	// 지난 5일간 총매출
	public List<Integer> getSales(@Param("member_id") Long member_id,
			@Param("start_date") Date start_date,
			@Param("end_date")	Date end_date);
	
	public List<ProductDTO> getMyProducts(@Param("member_id") Long member_id);
	public List<ReviewBoardDTO> getMyReviews(@Param("member_id") Long member_id);
	
	public int updateState(@Param("purc_id") Long purc_id,
						   @Param("next") String next);		
}

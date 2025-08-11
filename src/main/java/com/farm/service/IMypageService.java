package com.farm.service;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
	
	public List<Integer> getSoldNum(@Param("member_id") Long member_id,
						@Param("start_date") Date start_date,
						@Param("end_date")	Date end_date);
	
	public List<Integer> getSales(@Param("member_id") Long member_id,
			@Param("start_date") Date start_date,
			@Param("end_date")	Date end_date);
}

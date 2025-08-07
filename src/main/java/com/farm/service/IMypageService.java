package com.farm.service;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMypageService {
	// 구매자용
	public int getOrderCnt(Long member_id); // 주문수
	public int getReviewCnt(Long member_id); // 리뷰수
	public int getInquiryCnt(Long member_id); // 문의수
	
	// 판매자용
	public int getCheckOrder(Long member_id); // 주문확인중
	public int getPrepareOrder(Long member_id); // 상품준비중
	public int getDeliOrder(Long member_id); // 배송중
	public int getCompleteOrder(Long member_id); // 배송완료
	public int getInquiryCnt_Seller(Long member_id); // 문의수(판매자)
	
}

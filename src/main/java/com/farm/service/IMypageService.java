package com.farm.service;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMypageService {
	public int getOrderCnt(Long member_id);
	public int getReviewCnt(Long member_id);
	public int getInquiryCnt(Long member_id);
}

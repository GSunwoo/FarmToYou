package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.InquiryDTO;
import com.farm.dto.PageDTO;

@Mapper
public interface IInquiryService {
	
	
	public int getTotalCount(PageDTO pageDTO);
	public ArrayList<InquiryDTO> selectInq(@Param("member_id") Long member_id);
	
	public int insertInq(InquiryDTO inquiryDTO);
	
	public int updateInquiry(@Param("title") String title, @Param("content") String content);
	
	public int deleteInquiry(@Param("inquiry_id") Long inquiry_id);
	
	
}

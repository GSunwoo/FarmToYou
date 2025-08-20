package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.InquiryDTO;
import com.farm.dto.PageDTO;

@Mapper
public interface IInquiryService {
   
   //Paging 처리를 위한 게시물 카운트
   public int getTotalCount(PageDTO pageDTO);
   //게시판 목록
   public ArrayList<InquiryDTO> selectInq(PageDTO pageDTO);
   
   public int insertInq(InquiryDTO inquiryDTO);
   
   InquiryDTO inquiryDetail(InquiryDTO inquiryDTO);
   
   //수정
   public int updateInquiry(InquiryDTO inquiryDTO);
   //삭제
   public int deleteInquiry(@Param("inquiry_id") Long inquiry_id, @Param("member_id") Long member_id);
   
   
}

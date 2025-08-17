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
   public ArrayList<InquiryDTO> selectInq(@Param("member_id") Long member_id);
   
   public int insertInq(InquiryDTO inquiryDTO);
   //수정
   public int updateInquiry(@Param("title") String title, @Param("content") String content, @Param("inquiry_id") Long inquiry_id);
   //삭제
   public int deleteInquiry(@Param("inquiry_id") Long inquiry_id);
   
   
}

package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.farm.dto.ReviewBoardDTO;

@Mapper
public interface ReviewBoardService {
	
	//목록, 게시물 갯수 카운트
	public int getTotalCount(ReviewBoardDTO reviewboardDTO);
	
	public ArrayList<ReviewBoardDTO> listPage(ReviewBoardDTO reviewboardDTO);
	//뷰
	public ReviewBoardDTO view(ReviewBoardDTO reviewboardDTO);
	//조회수 증가
	public void visitCountPlus(ReviewBoardDTO dto);
	
}

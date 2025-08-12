package com.farm.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.farm.dto.PageDTO;
import com.farm.dto.ReviewBoardDTO;

@Mapper
public interface ReviewBoardService {
	
	//목록, 게시물 갯수 카운트
	public int getTotalCount(ReviewBoardDTO reviewboardDTO);
	
	public ArrayList<ReviewBoardDTO> listPage(PageDTO pageDTO);
	//뷰
	public ReviewBoardDTO view(ReviewBoardDTO reviewboardDTO);
	
	public ReviewBoardDTO selectView(Long review_id);

	public int write(ReviewBoardDTO reviewboardDTO);
	
	public int getReviewById(Long review_id);
	
	public int edit(ReviewBoardDTO reviewboardDTO);
}

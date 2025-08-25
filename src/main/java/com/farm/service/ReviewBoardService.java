package com.farm.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.junit.runners.Parameterized.Parameters;

import com.farm.dto.PageDTO;
import com.farm.dto.ReviewBoardDTO;

import lombok.experimental.PackagePrivate;

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
	
	public ArrayList<ReviewBoardDTO> getReviewPage(ReviewBoardDTO reviewboardDTO);
	//좋아요
	public boolean toggleLike(Long memberId, Long review_id);
	//좋아요 확인
	public  int existsLike(@Param("reviewId") Long reviewId,@Param("memberId") Long memberId);
	//좋아요 카운트
	public int countLike(Long reviewId);
	//좋아요 삭제
	public int deleteLike(@Param("reviewId") Long reviewId,
			@Param("memberId") Long memberId);
	//좋아요삽입
	public int insertLike(@Param("reviewId") Long reviewId,
			@Param("memberId") Long memberId);
	
	public int existReview(@Param("purc_id") Long purc_id);
	
	public int deleteReivew(@Param("reviewId") Long reviewId);
	
	/* 상세페이지에서 리뷰 연동*/
	public ArrayList<ReviewBoardDTO> loadReview(@Param("prod_id") Long prod_id);
	
	public List<ReviewBoardDTO> selectReviewByMember(@Param("member_id") Long member_id);
	
	public List<ReviewBoardDTO> selectReviewBySeller(@Param("member_id") Long member_id);
}

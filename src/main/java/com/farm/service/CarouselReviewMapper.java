package com.farm.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.farm.dto.ReviewBoardDTO;

@Mapper
public interface CarouselReviewMapper {

	List<ReviewBoardDTO> selectTopLiked(@Param("reviewPage") int reviewPage);
}

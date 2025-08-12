package com.farm.service;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;

import com.farm.dto.ReviewImgDTO;

@Mapper
public interface ReviewImgService {

	public int insertImg(ReviewImgDTO reviewimgDTO);
	public ArrayList<ReviewImgDTO> selectImg(ReviewImgDTO reviewimgDTO);
	public int deleteImg(ReviewImgDTO reviewimgDTO);
	public void setIdx(Long idx);

	
}

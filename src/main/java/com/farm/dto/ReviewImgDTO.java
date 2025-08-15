package com.farm.dto;

import lombok.Data;

@Data
public class ReviewImgDTO {

	private Long reviewimg_id; //리뷰 이미지 아이디
	private Long idx;
	private String filename; 
	private Long review_id;
	private String main;
	

}

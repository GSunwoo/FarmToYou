package com.farm.dto;

import java.time.LocalDate;


import lombok.Data;

@Data
public class ReviewBoardDTO {
	
	private Long review_id;
	private Long member_id;
	private LocalDate postdate;
	private String title;
 	private String content;
	private int star;
	private String evaluation;
	private int review_like; //좋아요 수 
	private Long prod_id; //상품 아이디
	private boolean review_liked; //좋아요 여부
	
}

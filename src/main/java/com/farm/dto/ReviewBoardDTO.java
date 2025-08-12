package com.farm.dto;

import java.time.LocalDate;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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
	//join시켜서 가져올 추가 정보
	private String name;//작성자
	
}

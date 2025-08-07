package com.farm.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class ReviewBoardDTO {
	
	private String review_id;
	private String member_id;
	private LocalDate postdate;
	private String title;
 	private String content;
	private int star;
	private String evaluation;
	private int visitcount;
}

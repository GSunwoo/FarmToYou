package com.farm.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class CommentDTO {

	private Long com_id;
	private String com_content;
	private LocalDateTime com_date;
	private Long member_id;
	private Long inquiry_id;
	
}

package com.farm.dto;

import lombok.Data;

@Data
public class InquiryDTO {
	
	private Long inquiry_id;
	private Long member_id;
	private Long prod_id;
	private String title;
	private String content;
	
	private String user_id;
}

package com.farm.dto;

import lombok.Data;

@Data
public class PageDTO {

	private int start;
	private int end;
	
    private Long member_id; // 회원별 조회 조건 추가
}

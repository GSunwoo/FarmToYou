package com.farm.dto;

import lombok.Data;

@Data
public class AddressDTO {

	// 주소
	private Long member_id; //유저 고유번호
	private Long addr_id; //주소 고유번호
	private String zipcode;
	private String addr1;
	private String addr2;
	private Integer main;
}

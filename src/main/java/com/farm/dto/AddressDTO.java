package com.farm.dto;

import lombok.Data;

@Data
public class AddressDTO {

	// 주소
	private String member_id;
	private Long addr_id;
	private String zipcode;
	private String addr1;
	private String addr2;
}

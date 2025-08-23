package com.farm.dto;

import lombok.Data;

@Data
public class FarmDTO {

	// 판매자용(사업장 관련 정보)
	private Long member_id;
	private Long farm_id;
	private String owner_name;
	private String brand_name;
	private String com_zip;
	private String com_addr1;
	private String com_addr2;
	private String depositor;
	private String bank;
	private String account;
}

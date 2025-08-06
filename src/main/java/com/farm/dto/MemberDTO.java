package com.farm.dto;

import lombok.Data;

@Data
public class MemberDTO {
	// 구매자, 판매자 공통
	private String user_type;
	private String user_id;
	private String user_pw;
	private String name;
	private String phone_num;
	private String emailid;
	private String emaildomain;
	
	// 주소
//	private String zipcode;
//	private String addr1;
//	private String addr2;
	
	// 판매자용(사업장 관련 정보)
//	private String farm_id;
//	private String owner_name;
//	private String brand_name;
//	private String com_zip;
//	private String com_addr1;
//	private String com_addr2;
//	private String entryman;
//	private String bank;
//	private String account;
}

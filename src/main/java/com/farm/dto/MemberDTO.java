package com.farm.dto;

import lombok.Data;

@Data
public class MemberDTO {
	private String user_type;
	private String user_id;
	private String user_pw;
	private String name;
	private String phone_num;
	private String email;
	private String zipcode;
	private String addr1;
	private String addr2;
	private String farm_id;
}

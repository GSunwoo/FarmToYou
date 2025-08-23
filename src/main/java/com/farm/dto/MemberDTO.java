package com.farm.dto;

import lombok.Data;

@Data
public class MemberDTO {
	// 구매자, 판매자 공통
	private Long member_id;
	private String user_type;
	private String user_id;
	private String user_pw;
	private String name;
	private String phone_num;
	private String emailid;
	private String emaildomain;
	private Integer enable;
}

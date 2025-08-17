package com.farm.dto;

import lombok.Data;

@Data
public class PayDTO {
	public Long member_id;   // 멤버 아이디
	public String name; 	 // 구매자 이름
	public String phone_num; // 휴대폰 번호
	private String emailid;     
	private String emaildomain; // 이메일
	
	// 구매정보
	public Long prod_id;     // 상품 아이디
	public int prod_price;   // 상품 가격
	public String prod_name; // 상품명
}

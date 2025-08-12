package com.farm.dto;

import java.time.LocalDate;

import jakarta.persistence.Column;
import lombok.Data;

@Data
public class ProductDTO {
	//상품
	private Long prod_id;		// 상품 아이디
	private String prod_name;	// 명
	private int prod_price;		// 가격
	private int prod_stock;		// 재고
	private String prod_cate;	// 카테고리
	private Long prodimg_id;		// 이미지 아이디
	private Long member_id;		// 판매자 일련번호
	private String prod_content;// 설명
	private int prod_like;		// 좋아요
	private LocalDate prod_date;// 등록날짜
	private String filename;
}

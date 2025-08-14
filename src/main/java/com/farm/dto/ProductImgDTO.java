package com.farm.dto;

import lombok.Data;

@Data
public class ProductImgDTO {

	private Long prodimg_id; //내부에서 설정할거고
	private String filename; //이건 가져와서 변환할거고
	private Long idx; //이건 순서대로 들어오니까 상관없고
	private int main_idx; 
	private Long prod_id;
}

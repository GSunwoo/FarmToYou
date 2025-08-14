package com.farm.dto;

import lombok.Data;

@Data
public class WishlistDTO {
	
	private Long wish_id;
	private int prod_qty;
	private Long member_id;
	private String prod_id;
	
	private String prod_name;
	private int prod_price;
}

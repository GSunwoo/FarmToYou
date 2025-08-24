package com.farm.dto;

import lombok.Data;

@Data
public class OrderCacheDTO {
	private String order_num;
	private Long prod_id;
	private Integer qty;
	private Long wish_id;
}

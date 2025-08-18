package com.farm.dto;

import lombok.Data;

@Data
public class PurchaseDTO {
	private Long prod_id;
	private Long member_id;
	private String order_num;
	private String purc_request;
	private Integer qty;
}

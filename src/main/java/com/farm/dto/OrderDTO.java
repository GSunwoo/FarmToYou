package com.farm.dto;

import lombok.Data;

@Data
public class OrderDTO {
	private String order_num;
	private String purc_date;
	private String purc_state;
	private Integer qty;
	private Long prod_id;
	private String prod_name;
	private Integer prod_price;
}

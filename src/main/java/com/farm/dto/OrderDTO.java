package com.farm.dto;

import lombok.Data;

@Data
public class OrderDTO {
	private String order_num;
	private Long prod_id;
	private String purc_date;
	private String prod_name;
	private Integer prod_price;
	private String purc_state;
	private Integer qty;
}

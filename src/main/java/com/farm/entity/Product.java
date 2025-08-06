package com.farm.entity;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.SequenceGenerator;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
@Entity
public class Product {
	@Id
	@SequenceGenerator(
			name = "productSequence",
			sequenceName = "seq_product_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "productSequence")
	private Long prod_id;
	private String prod_name;
	private int prod_price;
	private int prod_stock;
	@Column(nullable = false)
	private String prod_cate;
	private Long prodimg_id;
	private Long member_id; // 판매자ID
	private String prod_content;
	private int prod_like;
	@Column(columnDefinition = "DATE DEFAULT SYSDATE",
			nullable = false)
	private Date prod_date;
}

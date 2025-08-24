package com.farm.entity;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 주문한 상품이 뭔지 임시로 저장해둘 테이블
@Data
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
@Entity
public class OrderCache {
	@Id
	@SequenceGenerator(
			name = "orderCacheSequence",
			sequenceName = "seq_orderCache_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "orderCacheSequence")
	private Long orderCache_id;
	@Column(nullable=false)
	private String order_num;
	@Column(nullable=false)
	private Long prod_id;
	@Column(nullable=false)
	private Integer qty;
	private Long wish_id;
}

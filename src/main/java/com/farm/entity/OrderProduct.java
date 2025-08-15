package com.farm.entity;

import com.farm.dto.OrderProductId;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
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
public class OrderProduct {

	@EmbeddedId
	private OrderProductId id; //복합키
	
	@ManyToOne
	@MapsId("prod_id")
	@JoinColumn(name = "prod_id")
	private Product product;
	
	
	@ManyToOne
	@MapsId("member_id")
	@JoinColumn(name = "member_id")
	private Member member;
}

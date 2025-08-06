package com.farm.entity;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.PrePersist;
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
public class Wishlist {
	@Id
	@SequenceGenerator(
			name = "wishlistSequence",
			sequenceName = "seq_wishlist_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "wishlistSequence")
	private Long wish_id;
	@Column(nullable = false, columnDefinition = "NUMBER DEFAULT 1")
	private int prod_qty;
	
	@JoinColumn(name = "member_id")
	@Column(nullable = false)
	private Member member;
	@JoinColumn(name = "prod_id")
	@Column(nullable = false)
	private Product product;
	
	@PrePersist
	protected void onPrePersist() {
		this.prod_qty = 1;
	}
}

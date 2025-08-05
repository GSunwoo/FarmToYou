package com.farm.entity;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
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
	private Long member_id;
	private Long prod_id;
	private int prod_qty;
}

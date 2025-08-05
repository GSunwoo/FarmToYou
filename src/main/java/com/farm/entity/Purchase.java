package com.farm.entity;

import java.sql.Date;
import java.time.LocalDate;

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
public class Purchase {
	@Id
	@SequenceGenerator(
			name = "purchaseSequence",
			sequenceName = "seq_purchase_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "purchaseSequence")
	private Long purc_id;
	private Long prod_id;
	private Long member_id; // 구매자ID
	private Long review_id;
	private Long purc_state;
	private Long purc_cmpl;
	private Long purc_request;
	private Date purc_date;
}

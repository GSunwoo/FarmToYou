package com.farm.entity;

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
public class Address {
	@Id
	@SequenceGenerator(
			name = "addressSequence",
			sequenceName = "seq_address_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "addressSequence")
	private Long addr_id;
	private String zipcode;
	private String addr1;
	private String addr2;
}

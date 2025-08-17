package com.farm.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrimaryKeyJoinColumn;
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
	@Column(nullable = false)
	private Long addr_id;
	@Column(nullable = false)
	private String zipcode;
	@Column(nullable = false)
	private String addr1;
	private String addr2;
	private Integer main;
	@ManyToOne
	@JoinColumn(name = "member_id")
	private Member member;
}

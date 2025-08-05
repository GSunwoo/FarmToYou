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
public class Inquiry {
	@Id
	@SequenceGenerator(
			name = "inquirySequence",
			sequenceName = "seq_inquiry_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "inquirySequence")
	private Long inquiry_id;
	private Long member_id;
	private String title;
	private String content;
	private Date postdate;
	private int visitcount;
}

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
public class Review {
	@Id
	@SequenceGenerator(
			name = "reviewSequence",
			sequenceName = "seq_review_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "reviewSequence")
	private Long review_id;
	private Long member_id;
	private Date postdate;
	private String title;
	private String content;
	private int star;
	private String evaluation;
	private int visitcount;
}

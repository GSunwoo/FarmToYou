package com.farm.entity;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;

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
	@JoinColumn
	private Long member_id;
	private String title;
	private String content;
	@Column(columnDefinition = "DATE DEFAULT SYSDATE")
	private LocalDate postdate;
	@Column(columnDefinition = "NUMBER DEFAULT 0")
	private int visitcount;
	
	@PrePersist
	protected void onPrePersist() {
		
		this.postdate = LocalDate.now();
		this.visitcount = 0;
		
	}
}

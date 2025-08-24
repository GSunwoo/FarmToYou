package com.farm.entity;

import java.sql.Date;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
public class Comment {

	@Id
	@SequenceGenerator(
			name = "commentSequence",
			sequenceName = "seq_comment_id",
			initialValue = 1,
			allocationSize = 1
			)
	@GeneratedValue(generator = "commentSequence")
	@Column(nullable = false)
	private Long com_id;
	@Column(nullable = false)
	private String com_content;
	@Column(nullable = false)
	private LocalDateTime com_date;
	
	@ManyToOne
	@JoinColumn(name = "member_id", nullable = false)
    private Member member; // 판매자
	@ManyToOne
	@JoinColumn(name = "inquiry_id", nullable = false)
	private Inquiry inquiry; //
	
	@PrePersist
	protected void onPrePersist() {
		this.com_date = LocalDateTime.now();
	}
	
}

package com.farm.entity;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
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
	@Column(nullable = false)
	private String title;
	@Column(nullable = false)
	private String content;
	@Column(nullable = false, columnDefinition = "DATE DEFAULT SYSDATE")
	private LocalDate postdate;
	@Column(nullable = false, columnDefinition = "NUMBER DEFAULT 0")
	private int visitcount;
	
	@ManyToOne
	@JoinColumn(name = "member_id", nullable = false)
	private Member member;
	@ManyToOne
	@JoinColumn(name = "prod_id", nullable = false)
	private Product product; 
	
	@OneToMany(mappedBy = "inquiry", cascade = CascadeType.REMOVE)
    private List<Comments> comments = new ArrayList<>();
	
	@PrePersist
	protected void onPrePersist() {
		
		this.postdate = LocalDate.now();
		this.visitcount = 0;
		
	}
}

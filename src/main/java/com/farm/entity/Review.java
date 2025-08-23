package com.farm.entity;

import java.sql.Date;
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
import jakarta.persistence.OneToOne;
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
	@Column(nullable = false, columnDefinition = "DATE DEFAULT SYSDATE")
	private Date postdate;
	@Column(nullable = false)
	private String title;
	@Column(nullable = false)
	private String content;
	@Column(nullable = false)
	private int star;
	private String evaluation;
	@Column(nullable = false, columnDefinition = "NUMBER DEFAULT 0")
	private int review_like;
	
	@ManyToOne
	@JoinColumn(name = "member_id", nullable = false)
	private Member member;
	@ManyToOne
	@JoinColumn(name = "prod_id", nullable = false)
	private Product product;
	
	@OneToOne
	@JoinColumn(name= "purc_id", unique = true)
	private Purchase purchase;
	
	@OneToMany(mappedBy = "review", cascade = CascadeType.REMOVE)
	private List<ReviewImg> reviewImg = new ArrayList<>();

	
	
	@PrePersist
	protected void onPrePersist() {
		this.postdate = new Date(System.currentTimeMillis());
		this.review_like = 0;
	}
}

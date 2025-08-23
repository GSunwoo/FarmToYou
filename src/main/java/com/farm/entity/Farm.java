package com.farm.entity;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PrimaryKeyJoinColumn;
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
public class Farm {
	@Id
	private Long farm_id; //사업자 번호
	@Column(nullable = false)
	private String owner_name;
	@Column(nullable = false)
	private String brand_name;
	@Column(nullable = false)
	private String com_zip;
	@Column(nullable = false)
	private String com_addr1;
	@Column(nullable = false)
	private String com_addr2;
	@Column(nullable = false)
	private String depositor;
	@Column(nullable = false)
	private String bank;
	@Column(nullable = false)
	private String account;
	@Column(nullable = false, columnDefinition = "VARCHAR(10) DEFAULT 'request'")
	private String confirm;
	
	@ManyToOne
	@JoinColumn(name = "member_id", nullable = false)
	private Member member;
	
	@OneToOne(mappedBy = "farm", cascade = CascadeType.REMOVE)
	private TradeImg tradeImg;
	
	@PrePersist
	protected void onPrePersist() {
		this.confirm = "request";
	}
}

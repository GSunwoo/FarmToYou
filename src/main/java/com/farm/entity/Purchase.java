package com.farm.entity;

import java.sql.Date;
import java.time.LocalDate;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
	@Column(nullable = false, length = 20,columnDefinition = "VARCHAR(255) DEFAULT 'chk_order'")
	private String purc_state; // 주문상태 (주문확인중/상품준비중/배송중/배송완료)(chk_order/prepare_order/deli_order/cmpl_order)
	@Column(nullable = false, columnDefinition = "NUMBER DEFAULT 1") // 0이면 결제 안된 상태
	private int purc_cmpl; // 결제상태
	private String purc_request; // 구매자 요청사항
	@Column(nullable = false, columnDefinition = "DATE DEFAULT SYSDATE")
	private Date purc_date;
	@Column(nullable = false)
	private String order_num;
	@Column(nullable = false)
	private Integer qty;
	
	@OneToOne(mappedBy = "purchase", cascade = CascadeType.REMOVE)
	private Review review;
	
	@ManyToOne
	@JoinColumn(name = "prod_id", nullable = false)
	private Product product; // 상품
	@ManyToOne
	@JoinColumn(name = "member_id", nullable = false)
	private Member member; // 판매자
	@PrePersist
	protected void onPrePersist() {
		this.purc_date = new Date(System.currentTimeMillis());
		this.purc_cmpl = 1;
		this.purc_state = "chk_order";
	}
}

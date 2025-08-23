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
public class Product {
	@Id
	@SequenceGenerator(
			name = "productSequence",
			sequenceName = "seq_product_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "productSequence")
	private Long prod_id;
	@Column(nullable = false)
	private String prod_name;
	@Column(nullable = false)
	private int prod_price;
	@Column(nullable = false)
	private int prod_stock;
	@Column(nullable = false)
	private String prod_cate;
	@Column(nullable = false)
	private String prod_content;
	@Column(nullable = false, columnDefinition = "NUMBER DEFAULT 0")
	private int prod_like;
	@Column(nullable = false, columnDefinition = "DATE DEFAULT SYSDATE")
	private Date prod_date;
	@Column(nullable = false, columnDefinition = "VARCHAR(10) DEFAULT 'request'")
	private String confirm;
	
	@ManyToOne
	@JoinColumn(name = "member_id", nullable = false)
    private Member member; // 판매자
	
	@OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
    private List<Purchase> purchase = new ArrayList<>();
	@OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
	private List<Inquiry> inquiry = new ArrayList<>();
	@OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
	private List<Review> review = new ArrayList<>();
	@OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
	private List<Wishlist> wishlist = new ArrayList<>();
	@OneToMany(mappedBy = "product", cascade = CascadeType.REMOVE)
	private List<ProductImg> productImg = new ArrayList<>();
	
	@PrePersist
	protected void onPrePersist() {
		this.prod_date = new Date(System.currentTimeMillis());
		this.confirm = "request";
	}
}

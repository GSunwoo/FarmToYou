package com.farm.entity;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
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
public class Member {
	@Id
	@SequenceGenerator(
			name = "memberSequence",
			sequenceName = "seq_member_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "memberSequence")
	private Long member_id;
	@Column(nullable = false)
	private String user_type;
	@Column(nullable = false, unique = true)
	private String user_id;
	@Column(nullable = false)
	private String user_pw;
	@Column(nullable = false)
	private String name;
	@Column(nullable = false)
	private String phone_num;
	@Column(nullable = false)
	private String emailid;
	@Column(nullable = false)
	private String emaildomain;
	@Column(nullable = false, columnDefinition = "NUMBER DEFAULT 50")
	private int trust_score;
	@Column(nullable = false, columnDefinition = "DATE DEFAULT SYSDATE")
	private Date regidate;
	@Column(nullable = false, columnDefinition = "NUMBER DEFAULT 1")
	private int enable;
	
	@OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
    private List<Purchase> purchase = new ArrayList<>();
	@OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
	private List<Farm> farm = new ArrayList<>();
	@OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
	private List<Address> address = new ArrayList<>();
	@OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
	private List<Inquiry> inquiry = new ArrayList<>();
	@OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
	private List<Paymethod> paymethod = new ArrayList<>();
	@OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
	private List<Product> product = new ArrayList<>();
	@OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
	private List<Review> review = new ArrayList<>();
	@OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
	private List<Wishlist> wishlist = new ArrayList<>();
	@OneToMany(mappedBy = "member", cascade = CascadeType.REMOVE)
	private List<Comments> comments = new ArrayList<>();
	
	@PrePersist
	protected void onPrePersist() {
		this.regidate = new Date(System.currentTimeMillis());
		this.trust_score = 50;
		this.enable = 1;
	}
	
}

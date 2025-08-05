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
	private String user_type;
	private String user_id;
	private String user_pw;
	private String name;
	private String phone_num;
	private String email;
	private int trust_score;
	private Date regidate;
	private Long addr_id;
	private Long pay_id;
	private Long farm_id;
}

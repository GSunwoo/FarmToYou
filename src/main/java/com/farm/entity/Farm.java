package com.farm.entity;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
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
	private Long farm_id;
	private String owner_name;
	private String brand_name;
	private String com_zip;
	private String com_addr1;
	private String com_addr2;
	private String entryman;
	private String account;
}

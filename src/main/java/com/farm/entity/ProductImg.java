package com.farm.entity;

import java.sql.Date;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
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
public class ProductImg {
	@Id
	@SequenceGenerator(
			name = "productImgSequence",
			sequenceName = "seq_productimg_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "productImgSequence")
	private Long prodimg_id;
	private String filename;
	private Long idx;
	private int main_idx;
	
	@ManyToOne
	@JoinColumn(name = "prod_id", nullable = false)
    private Product product; // 상품
}

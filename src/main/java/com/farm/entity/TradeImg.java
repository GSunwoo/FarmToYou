package com.farm.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
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
public class TradeImg {
	@Id
	@SequenceGenerator(
			name = "tradeImgSequence",
			sequenceName = "seq_tradeimg_id",
			initialValue = 1,
			allocationSize = 1
		)
	@GeneratedValue(generator = "tradeImgSequence")
	private Long tradeimg_id;
	private String filename;
	
	@OneToOne
	@JoinColumn(name = "farm_id", nullable = false)
    private Farm farm; // 상품
}

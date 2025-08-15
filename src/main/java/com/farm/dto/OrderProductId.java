package com.farm.dto;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

//이 클래스가 엔티티 안에 내장되는 복합키/값 객체임을 표시
@Embeddable
//동등성/해시코드 자동 생성(PK비교용)
@EqualsAndHashCode
//기본 생성자 자동 생성(JPA 필수)
@NoArgsConstructor
@Data

//복합키 클래스 만들기
public class OrderProductId implements Serializable {

	private Long prod_id;
	private Long member_id;
	
	
}

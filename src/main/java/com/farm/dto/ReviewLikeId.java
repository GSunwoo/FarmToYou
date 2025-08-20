package com.farm.dto;

import java.io.Serializable;
import java.util.Objects;

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
public class ReviewLikeId implements Serializable {

	private Long review_id;
	private Long member_id;
	
	 @Override
	    public boolean equals(Object o) {
	        if (this == o) return true;
	        if (!(o instanceof ReviewLikeId)) return false;
	        ReviewLikeId that = (ReviewLikeId) o;
	        return Objects.equals(review_id, that.review_id) &&
	               Objects.equals(member_id, that.member_id);
	    }

	    @Override
	    public int hashCode() {
	        return Objects.hash(review_id, member_id);
	    }
	
}

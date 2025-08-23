package com.farm.entity;


import java.sql.Date;
import java.time.LocalDate;

import com.farm.dto.ReviewLikeId;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.PrePersist;
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
public class ReviewLike {

    @EmbeddedId
    private ReviewLikeId id; // ★ 반드시 LikeId 타입이어야 함

    @ManyToOne
    @MapsId("review_id")  // → LikeId에 prod_id 필드 있어야 작동
    @JoinColumn(name = "review_id")
    private Review review;

    @ManyToOne
    @MapsId("member_id")  // → LikeId에 member_id 필드 있어야 작동
    @JoinColumn(name = "member_id")
    private Member member;
    
    @Column(nullable = false, columnDefinition = "DATE DEFAULT SYSDATE")
    private Date createdAt;
    
    //좋아요가 언제 눌렸는지를 기록하기 위해 
    @PrePersist
    public void prePersist() {
        if (createdAt == null) createdAt = new Date(System.currentTimeMillis());
    }
}

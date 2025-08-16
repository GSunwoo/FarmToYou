package com.farm.entity;


import com.farm.dto.LikeId;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
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
public class OrderProduct {

    @EmbeddedId
    private LikeId id; // ★ 반드시 LikeId 타입이어야 함

    @ManyToOne
    @MapsId("prod_id")  // → LikeId에 prod_id 필드 있어야 작동
    @JoinColumn(name = "prod_id")
    private Product product;

    @ManyToOne
    @MapsId("member_id")  // → LikeId에 member_id 필드 있어야 작동
    @JoinColumn(name = "member_id")
    private Member member;
    
}

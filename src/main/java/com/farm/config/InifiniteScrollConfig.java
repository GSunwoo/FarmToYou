package com.farm.config;

import org.springframework.context.annotation.Configuration;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import jakarta.annotation.PostConstruct;

//스프링에서 사용하는 ObjectMapper에 LocalDate, LocalDateTime 같은 자바 8날짜 타입을
//제대로 처리하도록 설정해주는 클래스
@Configuration
public class InifiniteScrollConfig {
	

	 private final ObjectMapper objectMapper;

	    public InifiniteScrollConfig(ObjectMapper objectMapper) {
	        this.objectMapper = objectMapper;
	    }

	    @PostConstruct
	    public void setup() {
	    	//LocalDate, LocalDateTime을 JSON으로 바꿔줄 수 있도록 모듈 등록하는 줄
	        objectMapper.registerModule(new JavaTimeModule());
	        //날짜를 숫자 대신 문자열로 보내게 하는 설정
	        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
	    }
}

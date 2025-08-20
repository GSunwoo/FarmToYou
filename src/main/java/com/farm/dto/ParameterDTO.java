package com.farm.dto;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ParameterDTO {

	private String searchWord;
	private List<String> searchWords;
	private int start;
	private int end;
	
	private Date lastWeek;
}

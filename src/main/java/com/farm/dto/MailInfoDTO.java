package com.farm.dto;

import lombok.Data;

@Data
public class MailInfoDTO {
	private String mailServer;
	private String from;
	private String to;
	private String subject;
	private String content;
}

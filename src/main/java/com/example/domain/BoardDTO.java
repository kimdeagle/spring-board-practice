package com.example.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDTO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updatedate;
	
	private int replyCnt;
	
}

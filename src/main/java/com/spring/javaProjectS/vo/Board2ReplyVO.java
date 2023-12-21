package com.spring.javaProjectS.vo;

import lombok.Data;

@Data
public class Board2ReplyVO {
	private int idx; 					
	private int boardIdx;		
	private int re_step;
	private int re_order;
	private String mid;
	private String nickName;
	private String wDate;
	private String hostIp;
	private String content;
}

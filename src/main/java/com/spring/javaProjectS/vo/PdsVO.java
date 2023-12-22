package com.spring.javaProjectS.vo;

import lombok.Data;

@Data
public class PdsVO {
	private int idx;
	private String mid;
	private String nickName;
	private String fName;
	private String fSName;
	private int fSize;
	private String title;
	private String part;
	private String pwd;
	private String fDate;
	private int downNum;
	private String openSw;
	private String content;
	private String hostIp;
	
	// 새글 처리시(24시간 이내) 날짜체크변수와 시간체크변수 선언
	private int date_diff;
	private int hour_diff;
	
}

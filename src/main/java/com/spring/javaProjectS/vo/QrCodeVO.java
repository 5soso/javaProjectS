package com.spring.javaProjectS.vo;

import lombok.Data;

@Data
public class QrCodeVO {
	//private int idx;
	private String mid;
	private String name;
	private String email;
	
	private String moveUrl;
	
	private String movieName;
	private String movieDate;
	private String movieTime;
	private int movieAdult;
	private int movieChild;
	
	private String movieTemp;
	
	private String publicShow;
	private String qrCodeName;
}

package com.spring.javaProjectS.vo;

import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//@Data
@Setter
@Getter
@ToString
public class TransactionVO {
	private int idx;
	
	@Size(min=1, max=20, message="아이디 길이가 잘못되었습니다./midSizeNo")
	private String mid; 
	
	@Size(min=1, max=20, message="성명의 길이가 잘못되었습니다./nameSizeNo")
	private String name;
	
	private int age;
	private String address;
	
	// user2 테이블에 추가된 필드
	private String job;
}

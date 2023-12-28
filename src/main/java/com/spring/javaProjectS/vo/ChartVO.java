package com.spring.javaProjectS.vo;

import lombok.Data;

@Data
public class ChartVO {
	/* 공통필드 */
	private String part;
	private String title;
	
	/* 수직막대차트(barV) */
	private String subTitle;
	private String xTitle;
	private String legend1;
	private String legend2;
	private String legend3;
	
	private String x1;
	private String x2;
	private String x3;
	private String x4;
	private String x1Value1;
	private String x1Value2;
	private String x1Value3;
	private String x2Value1;
	private String x2Value2;
	private String x2Value3;
	private String x3Value1;
	private String x3Value2;
	private String x3Value3;
	private String x4Value1;
	private String x4Value2;
	private String x4Value3;
	
	/* 최근 방문자수 담을 필드 */
	private String visitDate;
	private int visitCount;
}

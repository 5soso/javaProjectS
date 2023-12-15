package com.spring.javaProjectS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS.vo.GuestVO;

public interface GuestDAO {

	public List<GuestVO> guestList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int guestInput(@Param("vo") GuestVO vo);

	public int guestDelete(@Param("idx")  int idx);

	public int getTotRecCnt();

	
}

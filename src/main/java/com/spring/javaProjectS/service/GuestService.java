package com.spring.javaProjectS.service;

import java.util.List;

import com.spring.javaProjectS.vo.GuestVO;

public interface GuestService {

	public List<GuestVO> guestList(int startIndexNo, int pageSize);

	public int guestInput(GuestVO vo);

	public int adminLogin(String mid, String pwd);

	public int guestDelete(int idx);

	public int getTotRecCnt();


}

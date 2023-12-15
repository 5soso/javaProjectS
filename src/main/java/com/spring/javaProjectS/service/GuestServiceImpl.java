package com.spring.javaProjectS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS.dao.GuestDAO;
import com.spring.javaProjectS.vo.GuestVO;

@Service
public class GuestServiceImpl implements GuestService {

	@Autowired
	GuestDAO guestDAO;

	@Override
	public List<GuestVO> guestList(int startIndexNo, int pageSize) {
		return guestDAO.guestList(startIndexNo, pageSize);
	}

	@Override
	public int guestInput(GuestVO vo) {
		return guestDAO.guestInput(vo);
	}

	@Override
	public int adminLogin(String mid, String pwd) {
		int res = 0;
		if(mid.equals("admin") && pwd.equals("1234")) res = 1;
		return res;
	}

	@Override
	public int guestDelete(int idx) {
		return guestDAO.guestDelete(idx);
	}

	@Override
	public int getTotRecCnt() {
		return guestDAO.getTotRecCnt();
	} 
}

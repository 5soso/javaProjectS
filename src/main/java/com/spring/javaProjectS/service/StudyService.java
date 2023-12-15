package com.spring.javaProjectS.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaProjectS.vo.UserVO;

public interface StudyService {

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public UserVO getUserSearch(String mid);

	public List<UserVO> getUser2SearchMid(String mid);

	
}

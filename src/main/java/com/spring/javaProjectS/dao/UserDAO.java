package com.spring.javaProjectS.dao;

import java.util.List;

import com.spring.javaProjectS.vo.UserVO;

public interface UserDAO {

	public List<UserVO> getUserList(); // 앞에 public 붙이기. 패키지 달라도 불러 써야하니까. 제일 처음에만 붙여주면 됨

	public int setUserDelete(int idx);

	public List<UserVO> getUserSearch(String name);



}

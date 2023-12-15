package com.spring.javaProjectS.service;

import java.util.List;

import com.spring.javaProjectS.vo.UserVO;

public interface UserService {

	public List<UserVO> getUserList(); // 앞에 public 붙이기. 패키지 달라도 불러 써야하니까. 제일 처음에만 써주면 됨

	public int setUserDelete(int idx); // () 변수명 꼭 확인하기

	public List<UserVO> getUserSearch(String name);
	

	public List<UserVO> getUser2List();

	public List<UserVO> getUser2Search(String name);

	public int setUser2Delete(int idx);

	public int setUser2Input(UserVO vo);

	public int setUser2Update(UserVO vo);

}

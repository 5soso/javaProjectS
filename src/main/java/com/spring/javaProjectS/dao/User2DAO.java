package com.spring.javaProjectS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS.vo.UserVO;

public interface User2DAO { //SqlSession으로 넘기지 않고 바로 Mapper로 값을 넘긴다.

	public List<UserVO> getUser2List();

	public List<UserVO> getUser2Search(@Param("name") String name); //SqlSession을 거치지 않고, 바로 Mapper로 값을 넘긴다. @RequestParam이 아닌 @Param을 사용한다. 

	public int setUser2Delete(@Param("idx") int idx);

	public int setUser2Input(@Param("vo") UserVO vo); //객체 넘기기. *여러개로 넘길 땐 꼭 @Param 써야함. 안 적어줘도 값은 넘어가는데, 변수명을 꼭 써줘야한다. (데이터 하나 넘길 땐 @Param 안 적어도 됨.)

	public int setUser2Update(@Param("vo") UserVO vo);

	public UserVO getUserSearchVO(@Param("mid")  String mid);

	public List<UserVO> getUser2SearchMid(@Param("mid") String mid);

}

package com.spring.javaProjectS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS.vo.UserVO;

public interface User2DAO {

	public List<UserVO> getUser2List();

	public List<UserVO> getUser2Search(@Param("name") String name); //sqlSession을 거치지 않고, 바로 mapper로 값을 넘긴다. RequestPram이 아닌 pram 사용한다. 

	public int setUser2Delete(@Param("idx") int idx);

	public int setUser2Input(@Param("vo") UserVO vo); //객체도 넘겨버린다. *여러개로 넘길 땐 꼭 @param 써야함...변수명을 꼭 써줘야한다. 사실 데이터 하나 넘길 땐 @param 안 적어도 됨.

	public int setUser2Update(@Param("vo") UserVO vo);

}

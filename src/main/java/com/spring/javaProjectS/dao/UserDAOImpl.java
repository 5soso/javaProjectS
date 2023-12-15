package com.spring.javaProjectS.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.javaProjectS.vo.UserVO;

@Repository("userDAO")
public class UserDAOImpl implements UserDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<UserVO> getUserList() {
		List<UserVO> vos = sqlSession.selectList("userNS.getUserList"); //오버라이드 구현객체(?) 생성후, 타입복붙 + 담을바구니(vos,vo..) = 변수명복붙.sql(mapper이름.변수명(이 변수명은 mapper의 select id명과 통일하는게 좋다.));
		return vos;
	}

	@Override
	public int setUserDelete(int idx) {
		return sqlSession.delete("userNS.setUserDelete",idx); //변수 넘길 때 ', 변수명' 쓰면 됨.
	}

	@Override
	public List<UserVO> getUserSearch(String name) {
		List<UserVO> vos = sqlSession.selectList("userNS.getUserSearch" , name); //like 연산자 쓸 거라서 여러개 옴?.. (하나만 출력할 때는 seletListOne 씀 -- SqlSession Template)
		return vos;
	}
	
	
}

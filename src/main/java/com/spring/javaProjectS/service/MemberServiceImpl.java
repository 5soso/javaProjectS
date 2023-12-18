package com.spring.javaProjectS.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS.dao.MemberDAO;
import com.spring.javaProjectS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO MemberDAO;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return MemberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNickCheck(String nickName) {
		return MemberDAO.getMemberNickCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo) {
		//사진처리...
		vo.setPhoto("noimage.jpg");
		
		return MemberDAO.setMemberJoinOk(vo);
	}

	@Override
	public MemberVO getMemberPwdCheck(String mid) {
		return MemberDAO.getMemberPwdCheck(mid);
	}

	@Override
	public int setMemberPwdUpdate(String mid, String pwd) {
		return MemberDAO.setMemberPwdUpdate(mid, pwd);
	}


}

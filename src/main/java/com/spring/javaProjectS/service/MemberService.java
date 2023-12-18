package com.spring.javaProjectS.service;

import com.spring.javaProjectS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public MemberVO getMemberPwdCheck(String mid);

	public int setMemberPwdUpdate(String mid, String pwd);



}

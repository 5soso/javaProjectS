package com.spring.javaProjectS.service;

import com.spring.javaProjectS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public int setUserDel(String mid);

	public int setPwdChangeOk(String mid, String pwd);

	public int setMemberUpdateOk(MemberVO vo);

	public void setMemberPasswordUpdate(String mid, String pwd);

}

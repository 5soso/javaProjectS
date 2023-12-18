package com.spring.javaProjectS.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS.service.MemberService;
import com.spring.javaProjectS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	//회원 Login폼 보여주기
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();

		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}		
		
		return "member/memberLogin";
	}
	
	//회원 Login 체크
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "mid", defaultValue = "hkd1234", required = false) String mid,
			@RequestParam(name = "pwd", defaultValue = "1234", required = false) String pwd,
			@RequestParam(name = "idSave", defaultValue = "", required = false) String idSave) {
		MemberVO vo = memberService.getMemberIdCheck(mid);

		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "우수회원";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			// 2.쿠키저장/삭제
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				//cookieMid.setPath("/"); //jsp에서는 현재 자신의 경로 아래로 쿠키를 저장시킨다. 스프링은 자신의 위치부터 저장함.
				cookieMid.setMaxAge(60*60*24*7);
				response.addCookie(cookieMid);
			}
			// 쿠키 만료시간
			else {
			  Cookie[] cookies = request.getCookies();
			  for(int i=0; i<cookies.length; i++) {
			  	if(cookies[i].getName().equals("cMid")) {
			  		cookies[i].setMaxAge(0);
			  		response.addCookie(cookies[i]);
			  		break;
			  	}
			  }
			}
			return "redirect:/message/memberLoginOk?mid="+mid; //redirect의 model은 쿼리스트링방식으로 간다. model에 담아서 보내는 거나, url에 보내는 거나 같음
		}
		else {
			return "redirect:/message/memberLoginNo";
		}
	}
	
	// 회원 logout처리 
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		
		return "redirect:/message/memberLogout?mid="+mid;
	}
	
	// 회원 Join폼 보여주기
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet(HttpSession session) {
		return "member/memberJoin";
	}
	
	// 회원 Join폼 보여주기
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		// 아이디/닉네임 중복체크
		if(memberService.getMemberIdCheck(vo.getMid()) != null) return "redirect:/message/idCheckNo";
		if(memberService.getMemberNickCheck(vo.getNickName()) != null) return "redirect:/message/nickCheckNo";
		
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 회원 사진 처리(service객체에서 처리후 DB에 저장한다.)
		int res = memberService.setMemberJoinOk(vo);
		
		if(res == 1) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	// 아이디체크 - ajax처리
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	// 닉네임체크 - ajax처리
	@ResponseBody
	@RequestMapping(value = "/memberNickCheck", method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		MemberVO vo = memberService.getMemberNickCheck(nickName);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	// 메인 홈 보여주기
	@RequestMapping(value = "/memberMain", method = RequestMethod.GET)
	public String memberMainGet() {
		return "member/memberMain";
	}
	
	// 비밀번호 변경 홈 보여주기
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.GET)
	public String memberPwdUpdateGet() {
		return "member/memberPwdUpdate";
	}
	
	// 비번 변경전 기존 비밀번호 체크 처리
	@ResponseBody
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.POST)
	public String memberPwdCheckPost(String mid, String pwd) {
		
		MemberVO vo = memberService.getMemberPwdCheck(mid);
		
		if(passwordEncoder.matches(pwd, vo.getPwd())) {
			return "1";
		}
		else return "0";
	}
	
	// 비밀번호 변경처리
	@ResponseBody
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.POST)
	public String memberPwdUpdatePost(String pwd, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		
		pwd = passwordEncoder.encode(pwd);
		
		int res = memberService.setMemberPwdUpdate(mid, pwd);
		
		if(res != 0) return "1";
		else return "0";
	}
	
	
	
}

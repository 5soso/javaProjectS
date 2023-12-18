package com.spring.javaProjectS.controller;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS.common.ARIAUtil;
import com.spring.javaProjectS.common.SecurityUtil;
import com.spring.javaProjectS.service.StudyService;
import com.spring.javaProjectS.vo.MailVO;
import com.spring.javaProjectS.vo.UserVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	 
	@Autowired
	StudyService studyService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;

	@RequestMapping(value="/ajax/ajaxForm", method = RequestMethod.GET)
	public String ajaxFormGet() {
		return "study/ajax/ajaxForm";
	}
	
	@ResponseBody 
	@RequestMapping(value="/ajax/ajaxTest1", method = RequestMethod.POST)
	public String ajaxTest1Post(int idx) {
		//System.out.println("idx : " + idx);
		
		return idx+"";
	}
	
	@ResponseBody //(ajax가 문자형식으로 넘어가기 때문에 넘길때도) header에 문자형식으로 들어가서 전송하는 어노테이션이다.
	@RequestMapping(value="/ajax/ajaxTest2", method = RequestMethod.POST, produces="application/text; charset=utf8") //ajax 돌아갈 때 한글처리 꼮 하기
 	public String ajaxTest2Post(String str) {
		//System.out.println("str : " + str);
		
		return str;
	}
	
	@RequestMapping(value="/ajax/ajaxTest3_1", method = RequestMethod.GET)
	public String ajaxTest3_1Get(String str) {
		return "study/ajax/ajaxTest3_1";
	}
	
	@ResponseBody //클라이언트로 보내주는 문자형식 전송이다. @ResponseBody 어노테이션 안쓰면 전송오류 뜸
	@RequestMapping(value="/ajax/ajaxTest3_1", method = RequestMethod.POST)
	public String[] ajaxTest3_1Post(String dodo) {
		//String[] strArray = new String[100];
		//strArray  = studyService.getCityStringArray(dodo);
		//return strArray;
		
		/* 위의 세줄을 한줄로 축약, 동적배열처럼 만들어진다. 메소드 타입 맞추기(String[])*/
		return studyService.getCityStringArray(dodo);
	}
	
	@RequestMapping(value="/ajax/ajaxTest3_2", method = RequestMethod.GET)
	public String ajaxTest3_2Get() {
		return "study/ajax/ajaxTest3_2";
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest3_2", method = RequestMethod.POST)
	public ArrayList<String> ajaxTest3_2Post(String dodo) { // <>제너릭 줘야함. 이유 : 문자열..?
		return studyService.getCityArrayList(dodo);
	}
	
	@RequestMapping(value="/ajax/ajaxTest3_3", method = RequestMethod.GET)
	public String ajaxTest3_3Get() {
		return "study/ajax/ajaxTest3_3";
	}
	
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest3_3", method = RequestMethod.POST)
	public HashMap<Object, Object> ajaxTest3_3Post(String dodo) { //최상위 객체 Object로 key, value 타입을 지정.
		ArrayList<String> vos = studyService.getCityArrayList(dodo);
		
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		map.put("city", vos);
		
		return map;
	}
	
	/* -------------------------------------------------------------------------*/
	// DB 
	
	@RequestMapping(value="/ajax/ajaxTest4_1", method = RequestMethod.GET)
	public String ajaxTest4_1Get() {
		return "study/ajax/ajaxTest4_1";
	}
	
	// 개별검색 1인
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest4_1", method = RequestMethod.POST)
	public UserVO ajaxTest4_1Post(String mid) {
		return studyService.getUserSearch(mid);
	}
	
	// 회원정보 검색 여러명 
	@ResponseBody
	@RequestMapping(value="/ajax/ajaxTest4_2", method = RequestMethod.POST)
	public List<UserVO> ajaxTest4_2Post(String mid) {
		return studyService.getUser2SearchMid(mid);
	}

	/*===========================================================================================================================*/
	//암호화 
	
	// SHA256
	@RequestMapping(value="/password/sha256", method = RequestMethod.GET)
	public String sha256Get() {
		return "study/password/sha256";
	}
	
	@ResponseBody //ajax에서 필수로 적어주기 body태그에 실어서 보낸다는 뜻
	@RequestMapping(value="/password/sha256", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String sha256Post(String pwd) {
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		
		
		SecurityUtil security = new SecurityUtil();
		String encPwd = security.encryptSHA256(pwd+salt);
		
		pwd = "원본비밀번호 : " + pwd +  " / salt키 : " + salt + " / 암호화된 비밀번호 : " + encPwd;
		
		return pwd;
	}
	
	// UUID
	@RequestMapping(value="/uuid/uidForm", method = RequestMethod.GET)
	public String uidFormGet() {
		return "study/uuid/uidForm";
	}
	
	@ResponseBody
	@RequestMapping(value="/uuid/uidForm", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String uidFormPost() {
		UUID uid = UUID.randomUUID();
		return uid.toString();
	}
	
	
	// AIRA
	@RequestMapping(value="/password/aria", method = RequestMethod.GET)
	public String ariaGet() {
		return "study/password/aria";
	}
	
	@ResponseBody
	@RequestMapping(value="/password/aria", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String ariaPost(String pwd) throws InvalidKeyException, UnsupportedEncodingException {
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,8);
		
		String encPwd = "";
		String decPwd = "";
		
		encPwd = ARIAUtil.ariaEncrypt(pwd + salt); //static이면 클래스명으로 불러온다.
		decPwd = ARIAUtil.ariaDecrypt(encPwd);
		
		
		pwd = "원본비밀번호 : " + pwd + " / salt : " + salt + " / 암호화된 비밀번호 : " + encPwd + " / 복호화된 비밀s번호 : " + decPwd;
		
		return pwd;
	}
	
	// BCryptPasswordEncoder
	@RequestMapping(value="/password/bCryptPassword", method = RequestMethod.GET)
	public String bCryptPasswordGet() {
		return "study/password/bCryptPassword";
	}
	
	@ResponseBody
	@RequestMapping(value="/password/bCryptPassword", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String bCryptPasswordPost(String pwd) {
		String encPwd = "";
		encPwd = passwordEncoder.encode(pwd);
		
		pwd = "원본비밀번호 : " + pwd + " / 암호화된 비밀번호 : " + encPwd;
		
		return pwd;
	}
	
	/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
	
	//mail 전송 폼 호출
	@RequestMapping(value="/mail/mail", method = RequestMethod.GET)
	public String mailGet() {
		return "study/mail/mailForm";
	}
	
	//mail 전송하기
	@RequestMapping(value="/mail/mail", method = RequestMethod.POST)
	public String mailPost(MailVO vo, HttpServletRequest request) throws MessagingException {
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMassageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리하자..
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지 보관함의 내용(content)에, 발신자의 필요한 정보를 추가로 담아서 전송시켜주면 좋다...
		content = content.replace("\n", "<br>"); //<br/> 인식안하는 브라우저 있을 수도 있어서 지우기
		content += "<br><hr><h3>JavaProjectS 보냅니다.</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width=\"500px\" /></p>";
		content += "<p>방문하기 : <a href='49.142.157.251:9090/cjgreen'>JavaProject</a></p>";
		content += "<hr>";
		
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로와 파일명을 별도로 표시한다. 그런후 다시 보관함에 저장한다.
		//FileSystemResource file = new FileSystemResource("D:\\JavaProject\\springframework\\works\\javaProjectS\\src\\main\\webapp\\resources\\images\\main.jpg");
		//request.getSession().getServletContext().getRealPath("");
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.jpg"));
		messageHelper.addInline("main.jpg", file);
		
		// 첨부파일 보내기
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/chicago.jpg"));
		messageHelper.addAttachment("chicago.jpg", file);
		// zip파일 보내기 
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.zip"));
		messageHelper.addAttachment("main.zip", file);

		// 메일 전송하기
		mailSender.send(message);
		
		
		return "redirect:/message/mailSendOk";
	}
	
	
	
	
	
	
}


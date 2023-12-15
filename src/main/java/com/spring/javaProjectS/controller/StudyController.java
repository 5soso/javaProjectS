package com.spring.javaProjectS.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS.service.StudyService;
import com.spring.javaProjectS.vo.UserVO;

@Controller
@RequestMapping("/study")
public class StudyController {
	
	@Autowired
	StudyService studyService;
	

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

}


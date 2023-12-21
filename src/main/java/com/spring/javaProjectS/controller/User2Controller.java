package com.spring.javaProjectS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS.service.UserService;
import com.spring.javaProjectS.vo.UserVO;

@Controller
@RequestMapping("/user2")
public class User2Controller {

	@Autowired
	UserService userService;
	
	//user 전체 리스트
	@RequestMapping(value = "/user2List", method = RequestMethod.GET)
	public String user2ListGet(Model model) {
		List<UserVO> vos = userService.getUser2List();
		
		model.addAttribute("vos", vos);
		
		return "study/user/user2List";
	}
	
	//user 회원가입 처리
	// validator를 이용한 backend 유효성검사하기... 검사후 정확한 자료를 DB에 저장시켜준다. 
	@RequestMapping(value = "/user2List", method = RequestMethod.POST) //자신의 경로에서 post로 받음
	public String user2ListPost(@Validated UserVO vo, BindingResult bindingResult, Model model) { //회원가입폼에 있는 데이터를 vo로 받는다
		
		System.out.println("vo : " + vo);
		
		System.out.println("error : " + bindingResult.hasErrors());
		
		
		if(bindingResult.hasFieldErrors()) {
			List<ObjectError> list = bindingResult.getAllErrors();
			System.out.println("===========================================");
			
			String temp = "";
			for(ObjectError e : list) {
				System.out.println("메세지 : " + e.getDefaultMessage());
				temp = e.getDefaultMessage().substring(e.getDefaultMessage().indexOf("/")+1);
				if(temp.equals("midEmpty") ||temp.equals("nameEmpty") ||temp.equals("midSizeNo") ||temp.equals("nameSizeNo") ||temp.equals("nameSizeNo")) break;    
				else temp = "typeError";
			}
			System.out.println("temp : " + temp);
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");

			model.addAttribute("temp", temp);
			
			return "redirect:/message/validatorError";
			
		}
		
		
		//BackEnd 체크 완료후에 DB에 저장처리한다.
		int res = userService.setUser2Input(vo);
		
		if(res != 0) return "redirect:/message/user2InputOk";
		else return "redirect:/message/user2InputNo";
	}
	
	
	//user 개별 검색리스트
	@RequestMapping(value = "/user2Search", method = RequestMethod.GET)
	public String user2SearchGet(Model model, String name) {
		List<UserVO> vos = userService.getUser2Search(name);
		
		model.addAttribute("vos", vos);
		model.addAttribute("name", name);
		
		return "study/user/user2List";
	}
	
	//user 삭제 처리
	@RequestMapping(value = "/user2Delete", method = RequestMethod.GET)
	public String user2DeleteGet(Model model, int idx) { //int 자동형변환 된다.
		int res = userService.setUser2Delete(idx);
		
		if(res != 0) return "redirect:/message/user2DeleteOk";
		else  return "redirect:/message/user2DeleteNo";
	}
	
	//user 회원정보 수정 처리
	@RequestMapping(value = "/user2Update", method = RequestMethod.POST)
	public String user2UpdatePost(Model model, UserVO vo) { 
		int res = userService.setUser2Update(vo);
		
		if(res != 0) return "redirect:/message/user2UpdateOk";
		else  return "redirect:/message/user2UpdateNo";
	}
	
	
}

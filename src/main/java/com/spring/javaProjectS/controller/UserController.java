package com.spring.javaProjectS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS.service.UserService;
import com.spring.javaProjectS.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	
	
//	@Autowired @Qualifier("userServiceImpl")
//	UserService userService;
//	@Autowired
//	UserServiceImpl userService; 
	
	@Autowired
	UserService userService; //유지보수 할 때 관리하기 위해서 Service 우두머리 인터페이스 거치고, Service 구현객체로 보낸다. 

	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String userListGet(Model model) {
		
		List<UserVO> vos = userService.getUserList(); //arrayList보다 List타입을 많이 씀. 
		
		model.addAttribute("vos", vos); //vos에 담아서 view에 뿌릴 거임
		
		return "study/user/userList";
	}
	
	@RequestMapping(value = "/userDelete", method = RequestMethod.GET)
	public String userDeleteGet(int idx) {
		int res = userService.setUserDelete(idx);
		
		if(res != 0) return "redirect:/message/userDeleteOk";
		else return "redirect:/message/userDeleteNo";
	}
	
	@RequestMapping(value = "/userSearch", method = RequestMethod.GET)
	public String userSearchGet(String name, Model model) {
		List<UserVO> vos = userService.getUserSearch(name);
		
		model.addAttribute("vos", vos);
		
		return "study/user/userList";
	}
}

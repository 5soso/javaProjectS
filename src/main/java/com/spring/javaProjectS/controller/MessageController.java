package com.spring.javaProjectS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {

	@RequestMapping(value="/message/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, String mid, Model model) {
		
		if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", "유저가 삭제되었습니다.");
			model.addAttribute("url", "user/userList"); //member 앞에 '/' 뺐음. 중첩방지(message.jsp 가보기), 경로임
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("msg", "유저 삭제에 실패하였습니다.");
			model.addAttribute("url", "user/userList"); 
		}
		if(msgFlag.equals("user2DeleteOk")) {
			model.addAttribute("msg", "유저가 삭제되었습니다.");
			model.addAttribute("url", "user2/user2List"); 
		}
		else if(msgFlag.equals("user2DeleteNo")) {
			model.addAttribute("msg", "유저 삭제에 실패하였습니다.");
			model.addAttribute("url", "user2/user2List"); 
		}
		else if(msgFlag.equals("user2InputOk")) {
			model.addAttribute("msg", "회원가입 되었습니다.");
			model.addAttribute("url", "user2/user2List"); 
		}
		else if(msgFlag.equals("user2InputNo")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다.");
			model.addAttribute("url", "user2/user2List"); 
		}
		else if(msgFlag.equals("user2UpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정되었습니다.");
			model.addAttribute("url", "user2/user2List"); 
		}
		else if(msgFlag.equals("user2UpdateNo")) {
			model.addAttribute("msg", "회원정보 수정 실패하였습니다.");
			model.addAttribute("url", "user2/user2List"); 
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록에 글이 등록되었습니다.");
			model.addAttribute("url", "guest/guestList"); 
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "글등록에 실패하였습니다.");
			model.addAttribute("url", "guest/guestInput"); 
		}
		else if(msgFlag.equals("adminLoginOk")) {
			model.addAttribute("msg", "관리자님 로그인되었습니다.");
			model.addAttribute("url", "guest/guestList"); 
		}
		else if(msgFlag.equals("adminLoginNo")) {
			model.addAttribute("msg", "관리자 인증에 실패하였습니다.");
			model.addAttribute("url", "guest/adminLogin"); 
		}
		else if(msgFlag.equals("adminLogoutOk")) {
			model.addAttribute("msg", "관리자님 로그아웃되었습니다.");
			model.addAttribute("url", "guest/guestList"); 
		}
		else if(msgFlag.equals("guestDeleteOk")) {
			model.addAttribute("msg", "선택하신 게시글이 삭제되었습니다.");
			model.addAttribute("url", "guest/guestList"); 
		}
		else if(msgFlag.equals("guestDeleteNo")) {
			model.addAttribute("msg", "게시글 삭제에 실패하였습니다.");
			model.addAttribute("url", "guest/guestList"); 
		}
		
		return "include/message";
	}
}

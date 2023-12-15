package com.spring.javaProjectS.controller;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaProjectS.service.GuestService;
import com.spring.javaProjectS.vo.GuestVO;

@Controller
@RequestMapping("/guest")
public class GuestController {
	
	@Autowired //의존성 주입하는 것을 준비하는 중
	GuestService guestService; //접근제한자 default, private 상관없음
	
	@RequestMapping(value = "/guestList", method = RequestMethod.GET)
	public String guestListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required= false) int pag,
			@RequestParam(name="pageSize", defaultValue = "3", required= false) int pageSize) {
		
		int totRecCnt = guestService.getTotRecCnt();
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1 ;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		List<GuestVO> vos = guestService.guestList(startIndexNo, pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "guest/guestList";
	}
	
	// Guest 
	@RequestMapping(value = "/guestInput", method = RequestMethod.GET)
	public String guestInputGet() {
		return "guest/guestInput";
	}
	
	// Guest 방명록 글쓰기
	@RequestMapping(value = "/guestInput", method = RequestMethod.POST)
	public String guestInputPost(GuestVO vo) {
		int res = guestService.guestInput(vo);
		
		if(res != 0) return "redirect:/message/guestInputOk";
		else return "redirect:/message/guestInputNo"; 
	}
	
	// 관리자 로그인
	@RequestMapping(value = "/adminLogin", method = RequestMethod.GET)
	public String adminLoginGet() {
		return "guest/adminLogin";
	}
	
	// 관리자 로그인
	@RequestMapping(value = "/adminLogin", method = RequestMethod.POST)
	public String adminLoginPost(HttpSession session,
			@RequestParam(name="mid", defaultValue = "guest", required = false) String mid, 
			@RequestParam(name="pwd", defaultValue = "", required = false) String pwd) { //required = false : 필수입력이 아니라는 뜻
		
		int res = guestService.adminLogin(mid, pwd);
		
		if(res != 0) {
			session.setAttribute("sAdmin", "adminOk");
			return "redirect:/message/adminLoginOk";
		}
		else return "redirect:/message/admingLoginNo"; 
	}
	
	// 관리자 로그아웃 - 로그아웃시에 세션 삭제하기
	@RequestMapping(value = "/adminLogout", method = RequestMethod.GET)  //Get방식인 이유 : 로그아웃 버튼이 주소를 통해서 이동하기 때문에.. form태그의 post 방식으로 submit으로 넘겼으면 post로 넘긴다.  
	public String adminLogoutGet(HttpSession session) {
		
		session.removeAttribute("sAdmin");
		/* session.invalidate(); 하면 안되는 이유 : invalidate는 세션을 완전히 삭제하는 것임.*/
		
		return "redirect:/message/adminLogoutOk";
	}
	
	// 방명록 삭제 guestDelete
	@RequestMapping(value = "/guestDelete", method = RequestMethod.GET) //get인 이유: view에서 쿼리스트링으로 idx값을 넘겼기 때문에
	public String guestDeleteGet(int idx) {
		
		int res = guestService.guestDelete(idx);
		if(res !=0 ) return "redirect:/message/guestDeleteOk";
		else return "redirect:/message/guestDeleteNo";
	}
	
}

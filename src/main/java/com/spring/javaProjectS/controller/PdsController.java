package com.spring.javaProjectS.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS.common.SecurityUtil;
import com.spring.javaProjectS.pagination.PageProcess;
import com.spring.javaProjectS.pagination.PageVO;
import com.spring.javaProjectS.service.PdsService;
import com.spring.javaProjectS.vo.PdsVO;

@Controller
@RequestMapping("/pds")
public class PdsController {

	@Autowired
	PdsService pdsService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 자료실 보여주기
	@RequestMapping(value = "/pdsList", method = RequestMethod.GET)
	public String pdsListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part
			) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "pds", part, "");
		
		List<PdsVO> vos = pdsService.getPdsList(pageVO.getStartIndexNo(),pageSize,part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "pds/pdsList";
	}

	// 자료실 파일 업로드폼 보여주기
	@RequestMapping(value = "/pdsInput", method = RequestMethod.GET)
	public String pdsListGet(Model model, String part) {
		model.addAttribute("part", part);
		return "pds/pdsInput";
	}
	
	// 자료실 파일 업로드 처리
	@RequestMapping(value = "/pdsInput", method = RequestMethod.POST)
	public String pdsInputPost(PdsVO vo, MultipartHttpServletRequest file) {
		SecurityUtil security = new SecurityUtil();
		UUID uid = UUID.randomUUID();
		String salt = uid.toString().substring(0,4);
		
		String pwd = salt + security.encryptSHA256(vo.getPwd()); 
		vo.setPwd(pwd);
		
		int res = pdsService.setPdsInput(vo, file);
		
		if(res == 1) return "redirect:/message/pdsInputOk";
		else return "redirect:/message/pdsInputNo";
	}
	
	// 자료실 파일 다운받기 처리
	@ResponseBody
	@RequestMapping(value = "/pdsDownNumCheck", method = RequestMethod.POST)
	public String pdsDownNumCheckPost(int idx) {
		int res = pdsService.setPdspdsDownNumCheck(idx);
		return res + "";
	}
	
	// 자료실 게시글 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/pdsDeleteOk", method = RequestMethod.POST)
	public String pdsDeleteOkPost(int idx, String pwd) {
		PdsVO vo = pdsService.getIdxSearch(idx);
		//String tempPwd = vo.getPwd().substring(0,4);
		
		int res = 0;
		SecurityUtil security = new SecurityUtil();
		if(security.encryptSHA256(pwd).equals(vo.getPwd().substring(4))) {
			res = pdsService.setPdsDelete(vo);
		}
		
		return res+"";
	}
}


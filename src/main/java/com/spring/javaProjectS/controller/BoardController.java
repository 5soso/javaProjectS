package com.spring.javaProjectS.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS.service.BoardService;
import com.spring.javaProjectS.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	
	@Autowired
	BoardService boardService; 
	
	//게시판 리스트 보여주기
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(Model model) {
	  ArrayList<BoardVO> vos = boardService.getBoardList();
	  
	  model.addAttribute("vos", vos);
		
		return "board/boardList";
	}
	
	//글쓰기 폼 보여주기
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	//글쓰기 등록 처리
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {
		int res = boardService.setBoardInputPost(vo);
		
		if(res == 1) return "redirect:/message/boardInputOk";
		else return "redirect:/message/boardInputNo";
	}
	
	//게시글 상세보기
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(int idx, Model model) {
		BoardVO vo = boardService.getBoardContent(idx);
		model.addAttribute("vo", vo);
		return "board/boardContent";
	}

	
}

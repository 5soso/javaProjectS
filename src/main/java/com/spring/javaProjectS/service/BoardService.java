package com.spring.javaProjectS.service;

import java.util.ArrayList;

import com.spring.javaProjectS.vo.BoardVO;

public interface BoardService {

	public ArrayList<BoardVO> getBoardList();

	public int setBoardInputPost(BoardVO vo);

	public BoardVO getBoardContent(int idx);


}

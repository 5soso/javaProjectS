package com.spring.javaProjectS.service;

import java.util.List;

import com.spring.javaProjectS.vo.BoardVO;

public interface BoardService {

	public int setBoardInputPost(BoardVO vo);

	public BoardVO getBoardContent(int idx);

	public List<BoardVO> getBoardList(int startIndexNo, int pageSize);

	public void imgCheck(String content);

	public int setBoardDelete(int idx);

	public void imgDelete(String content);

	public void imgBackup(String content);

	public int setBoardUpdate(BoardVO vo);


}

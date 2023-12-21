package com.spring.javaProjectS.service;

import java.util.List;

import com.spring.javaProjectS.vo.Board2ReplyVO;
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

	public BoardVO getPreNextSearch(int idx, String str);

	public Board2ReplyVO getBoardParentReplyCheck(int boardIdx);

	public int setBoardReplyInput(Board2ReplyVO replyVO);

	public List<Board2ReplyVO> getBoard2Reply(int idx);

	public void setReplyOrderUpdate(int boardIdx, int re_order);

	public void setReadNumPlus(int idx);

	public List<BoardVO> getBoardSearchList(int startIndexNo, int pageSize, String search, String searchString);


}

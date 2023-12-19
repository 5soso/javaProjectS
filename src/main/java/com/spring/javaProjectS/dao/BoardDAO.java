package com.spring.javaProjectS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS.vo.BoardVO;

public interface BoardDAO {

	public ArrayList<BoardVO> getBoardList();

	public int setBoardInputPost(@Param("vo") BoardVO vo);

	public BoardVO getBoardContent(@Param("idx") int idx);

	
	
}

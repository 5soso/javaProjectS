package com.spring.javaProjectS.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS.dao.BoardDAO;
import com.spring.javaProjectS.dao.PdsDAO;

@Service
public class PageProcess {
	
	@Autowired
	BoardDAO boardDao;
	
	@Autowired
	PdsDAO pdsDao;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) { //String section : 게시판 분류(게시판/자료실/방명록..등), part : 소분류(학습,여행,맛집..등)
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("board")) {
			if(part.equals(""))	totRecCnt = boardDao.totRecCnt(); //검색하지않을 때
			else { //검색할 때
				search = part;
				totRecCnt = boardDao.totRecCntSearch(search, searchString);
			}
		}
		else if(section.equals("pds")) totRecCnt = pdsDao.totRecCnt(part);
		 
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1 ;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);		
		pageVO.setPageSize(pageSize);		
		pageVO.setTotRecCnt(totRecCnt);		
		pageVO.setTotPage(totPage);		
		pageVO.setStartIndexNo(startIndexNo);		
		pageVO.setCurScrStartNo(curScrStartNo);		
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);		
		pageVO.setLastBlock(lastBlock);		
		pageVO.setPart(part);
		pageVO.setSearch(search); //search/searchString 에서 search를 part로 받겠다. 이때 search(part)는 공백으로 온다... -> search로 바꿈
		pageVO.setSearchString(searchString);
		
		
		 return pageVO;
	}
	
	
}

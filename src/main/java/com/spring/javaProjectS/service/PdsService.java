package com.spring.javaProjectS.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS.vo.PdsVO;

public interface PdsService {

	public List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part);

	public int setPdsInput(PdsVO vo, MultipartHttpServletRequest file);

	public int setPdsDownNumCheck(int idx);

	public PdsVO getIdxSearch(int idx);

	public int setPdsDelete(PdsVO vo);

}

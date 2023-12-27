package com.spring.javaProjectS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS.vo.PdsVO;

public interface PdsDAO {

	public int totRecCnt(@Param("part") String part);

	public List<PdsVO> getPdsList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public int setPdsInput(@Param("vo") PdsVO vo);

	public int setPdsDownNumCheck(@Param("idx") int idx);

	public PdsVO getIdxSearch(@Param("idx") int idx);

	public int setPdsDelete(@Param("idx") int idx);

}

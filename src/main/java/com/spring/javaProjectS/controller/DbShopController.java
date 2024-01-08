package com.spring.javaProjectS.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS.service.DbShopService;
import com.spring.javaProjectS.vo.DbProductVO;

@Controller
@RequestMapping("/dbShop")
public class DbShopController {

	@Autowired
	DbShopService dbShopService;
	
	// 분류 등록폼 호출 및 출력
	@RequestMapping(value = "/dbCategory", method = RequestMethod.GET)
	public String dbCategoryGet(Model model) {
		List<DbProductVO> mainVOS = dbShopService.getCategoryMain();			// 대분류 리스트
		List<DbProductVO> middleVOS = dbShopService.getCategoryMiddle();	// 중분류 리스트
		List<DbProductVO> subVOS = dbShopService.getCategorySub();				// 소분류 리스트
		
		model.addAttribute("mainVOS", mainVOS);
		model.addAttribute("middleVOS", middleVOS);
		model.addAttribute("subVOS", subVOS);
		
		return "admin/dbShop/dbCategory";
	}
	
	// 대분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categoryMainInput", method=RequestMethod.POST)
	public String categoryMainInputPost(DbProductVO vo) {
		// 현재 기존에 생성된 대분류명이 있는지 체크...
		DbProductVO productVO = dbShopService.getCategoryMainOne(vo.getCategoryMainCode(), vo.getCategoryMainName());
		
		if(productVO != null) return "0";
		
		int res = dbShopService.setCategoryMainInput(vo);
		return res + "";
	}
	
	// 대분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categoryMainDelete", method=RequestMethod.POST)
	public String categoryMainDeletePost(DbProductVO vo) {
		// 현재 기존에 생성된 대분류코드가 있는지 체크...
		DbProductVO middleVO = dbShopService.getCategoryMiddleOne(vo);		// 삭제할 대분류항목에 중분류데이터가 있는지 검색처리
		
		if(middleVO != null) return "0";
		
		int res = dbShopService.setCategoryMainDelete(vo.getCategoryMainCode());	//  대분류항목 삭제처리
		return res + "";
	}
	
	// 중분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleInput", method=RequestMethod.POST)
	public String categoryMiddleInputPost(DbProductVO vo) {
		// 기존에 생성된 같은 중분류명이 있는지 체크...
		DbProductVO productVO = dbShopService.getCategoryMiddleOne(vo);
		
		if(productVO != null) return "0";
		
		int res = dbShopService.setCategoryMiddleInput(vo);	// 중분류항목 저장하기
		return res + "";
	}
	
	// 중분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleDelete", method=RequestMethod.POST)
	public String categoryMiddleDeletePost(DbProductVO vo) {
		// 중분류 하위항목이 있는지 체크...
		DbProductVO subVO = dbShopService.getCategorySubOne(vo);		// 삭제할 중분류항목에 소분류데이터가 있는지 검색처리
		
		if(subVO != null) return "0";
		
		int res = dbShopService.setCategoryMiddleDelete(vo.getCategoryMiddleCode());	//  중분류항목 삭제처리
		return res + "";
	}
	
	// 대분류명 선택하면 중분류명 가져오기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleName", method = RequestMethod.POST)
	public List<DbProductVO> categoryMiddleNamePost(String categoryMainCode) {
		return dbShopService.getCategoryMiddleName(categoryMainCode);
	}
	
	// 소분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categorySubInput", method=RequestMethod.POST)
	public String categorySubInputPost(DbProductVO vo) {
		// 기존에 생성된 같은 소분류명이 있는지 체크...
		DbProductVO productVO = dbShopService.getCategorySubOne(vo);
		
		if(productVO != null) return "0";
		
		int res = dbShopService.setCategorySubInput(vo);	// 소분류항목 저장하기
		return res + "";
	}
	
	// 중분류 선택시에 소분류항목명을 가져오기
	@ResponseBody
	@RequestMapping(value = "/categorySubName", method = RequestMethod.POST)
	public List<DbProductVO> categorySubNamePost(String categoryMainCode, String categoryMiddleCode) {
		return dbShopService.getCategorySubName(categoryMainCode, categoryMiddleCode);
	}
	
	// 소분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categorySubDelete", method=RequestMethod.POST)
	public String categorySubDeletePost(DbProductVO vo) {
		// 소분류 하위항목(상품명)이 있는지 체크...
		DbProductVO categoryProdectVO = dbShopService.getCategoryProductName(vo);		// 삭제할 소분류항목에 상품이 있는지 검색처리
		
		if(categoryProdectVO != null) return "0";
		
		int res = dbShopService.setCategorySubDelete(vo.getCategorySubCode());	//  소분류항목 삭제처리
		return res + "";
	}
	
	// 관리자 상품등록시에 ckeditor에 그림을 올린다면 dbShop폴더에 저장되고, 저장된 파일을 브라우저 textarea상자에 보여준다.
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/dbShop/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		outStr.close();
	}
	
  // 상품 등록을 위한 폼 보기..
	@RequestMapping(value = "/dbProduct", method=RequestMethod.GET)
	public String dbProductGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain();
		model.addAttribute("mainVos", mainVos);
		return "admin/dbShop/dbProduct";
	}
	
	// 상품 등록 처리하기
	@RequestMapping(value = "/dbProduct", method=RequestMethod.POST)
	public String dbProductPost(MultipartFile file, DbProductVO vo) {
		// 이미지파일 업로드시에 dbShop폴더에서 'dbShop/product'폴더로 복사처리...후~ 처리된 내용을 DB에 저장하기
		int res = dbShopService.imgCheckProductInput(file, vo);
		
		if(res != 0) return "redirect:/message/dbProductInputOk";
		return "redirect:/message/dbProductInputNo";
	}
	
}

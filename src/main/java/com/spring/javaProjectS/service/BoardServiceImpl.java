package com.spring.javaProjectS.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaProjectS.dao.BoardDAO;
import com.spring.javaProjectS.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDAO boardDAO;

	@Override
	public int setBoardInputPost(BoardVO vo) {
		return boardDAO.setBoardInputPost(vo);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		return boardDAO.getBoardList(startIndexNo, pageSize); /* DAO에 작업할 경우가 있을 때 */
	}

	@Override
	public void imgCheck(String content) {
		//				0					1					2					3					4					5					
		//				012345678901234567890123456789012345678901234567890
		//<p><img src="/javaProjectS/data/ckeditor/231220123322_3.jpg" style="height:440px; width:387px" /></p> 시작위치 : 33번째
		//<p><img src="/javaProjectS/data/board/231220123322_3.jpg" style="height:440px; width:387px" /></p> 시작위치 : 30번째... 계속 바뀜
		
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
	
		int position = 33;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "board/" + imgFile;
		
			fileCopyCheck(origFilePath,copyFilePath); // ckeditor폴더의 그림파일을 board폴더위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false; 
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	//파일을 복사처리한다.
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048]; 
			
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes,0,cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
					
 		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public int setBoardDelete(int idx) {
		return boardDAO.setBoardDelete(idx);
	}

	//그림파일 삭제 처리
	@Override
	public void imgDelete(String content) {
		//	      0					1					2					3					4					5					
		//				012345678901234567890123456789012345678901234567890
		//<p><img src="/javaProjectS/data/board/231220123322_3.jpg" style="height:440px; width:387px" /></p> 시작위치 : 30번째... 계속 바뀜
		//<p><img src="/javaProjectS/data/ckeditor/231220123322_3.jpg" style="height:440px; width:387px" /></p> 시작위치 : 33번째
		
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;
			
			fileDelete(origFilePath); // ckeditor폴더의 그림파일을 삭제처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false; 
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}
  
	// 실제로 서버에 저장된 파일을 삭제처리한다.
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	// 그림파일 수정 처리
	@Override
	public void imgBackup(String content) {
		//				0					1					2					3					4					5					
		//				012345678901234567890123456789012345678901234567890
		//<p><img src="/javaProjectS/data/board/231220123322_3.jpg" style="height:440px; width:387px" /></p> 시작위치 : 30번째... 계속 바뀜
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 30;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath,copyFilePath); // board폴더의 그림파일을 ckeditor폴더위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false; 
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	@Override
	public int setBoardUpdate(BoardVO vo) {
		return boardDAO.setBoardUpdate(vo);
	}
}

package com.spring.javaProjectS.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS.dao.PdsDAO;
import com.spring.javaProjectS.vo.PdsVO;

@Service
public class PdsServiceImpl implements PdsService {

	@Autowired
	PdsDAO pdsDAO;

	@Override
	public List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part) {
		return pdsDAO.getPdsList(startIndexNo, pageSize, part);
	}

	@Override
	public int setPdsInput(PdsVO vo, MultipartHttpServletRequest multiFile) { //Multipar..HttpServletRequest : jsp에 있는 form의 name 변수명과 똑같이 사용/ 파일을 여러개 가져오기 위함.
		// 서비스 객체에서 파일 업로드를 한다. 정상적으로 업로드되면 vo에 담아 보낸다.
		int res = 0;
		
		try {
			List<MultipartFile> fileList = multiFile.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			int fileSizes = 0;
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName);
			
				writeFile(file, sFileName); //뒤에 변수이름으로 file 하나를 저장한다.
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
				fileSizes += file.getSize();
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			vo.setFSize(fileSizes);
			
			res = pdsDAO.setPdsInput(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	private void writeFile(MultipartFile file, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		byte[] data = file.getBytes();
		FileOutputStream fos = new FileOutputStream(realPath + sFileName); //저장은 output, 클라이언트에서 사진을 보내서 저장하는 중
		fos.write(data);
		fos.close();
	}

	// file명 중복방지를 위한 서버에 저장될 실제 파일명 만들기
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		
		return fileName;
	}

	@Override
	public int setPdsDownNumCheck(int idx) {
		return pdsDAO.setPdsDownNumCheck(idx);
	}

	@Override
	public PdsVO getIdxSearch(int idx) {
		return pdsDAO.getIdxSearch(idx);
	}

	@Override
	public int setPdsDelete(PdsVO vo) {
		// 파일 삭제 처리
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		String[] fSNames = vo.getFSName().split("/");
		
		// 서버에 저장된 실제 파일을 삭제처리
		for(int i=0; i<fSNames.length; i++) {
			new File(realPath+fSNames[i]).delete();
		}
		return pdsDAO.setPdsDelete(vo.getIdx());
	}
	
}

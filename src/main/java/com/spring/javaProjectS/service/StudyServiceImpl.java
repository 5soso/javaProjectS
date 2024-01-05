package com.spring.javaProjectS.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.swing.ImageIcon;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javaProjectS.dao.StudyDAO;
import com.spring.javaProjectS.dao.User2DAO;
import com.spring.javaProjectS.vo.ChartVO;
import com.spring.javaProjectS.vo.KakaoAddressVO;
import com.spring.javaProjectS.vo.QrCodeVO;
import com.spring.javaProjectS.vo.TransactionVO;
import com.spring.javaProjectS.vo.UserVO;

import lombok.Data;
import net.coobird.thumbnailator.Thumbnailator;

@Service
public class StudyServiceImpl implements StudyService {
	
	@Autowired
	StudyDAO studyDAO;
	
	@Autowired
	User2DAO user2DAO; 

	@Override
	public String[] getCityStringArray(String dodo) {
		String[] strArray = new String[100];
		
		if(dodo.equals("서울")) {
			strArray[0] = "강남구";
			strArray[1] = "서초구";
			strArray[2] = "관악구";
			strArray[3] = "마포구";
			strArray[4] = "영등포구";
			strArray[5] = "강북구";
			strArray[6] = "동대문구";
			strArray[7] = "성북구";
		}
		else if(dodo.equals("경기")) {
			strArray[0] = "수원시";
			strArray[1] = "안양시";
			strArray[2] = "안성시";
			strArray[3] = "평택시";
			strArray[4] = "용인시";
			strArray[5] = "의정부시";
			strArray[6] = "광명시";
			strArray[7] = "성남시";
		}
		else if(dodo.equals("충북")) {
			strArray[0] = "청주시";
			strArray[1] = "충주시";
			strArray[2] = "괴산군";
			strArray[3] = "제천시";
			strArray[4] = "단양군";
			strArray[5] = "증평군";
			strArray[6] = "옥천군";
			strArray[7] = "영동군";
		}
		else if(dodo.equals("충남")) {
			strArray[0] = "천안시";
			strArray[1] = "아산시";
			strArray[2] = "논산시";
			strArray[3] = "공주시";
			strArray[4] = "부여군";
			strArray[5] = "홍성군";
			strArray[6] = "예산군";
			strArray[7] = "청양군";
		}
		
		return strArray;
	}

	@Override
	public ArrayList<String> getCityArrayList(String dodo) {
		ArrayList<String> vos = new ArrayList<String>();
		
		//처음 지정범위 선택후 shift 누르고 alt+shift+a 누르기 
		if(dodo.equals("서울")) {
			vos.add("강남구");
			vos.add("서초구");
			vos.add("관악구");
			vos.add("마포구");
			vos.add("영등포구");
			vos.add("강북구");
			vos.add("동대문구");
			vos.add("성북구");
		}
		else if(dodo.equals("경기")) {
			vos.add("수원시");
			vos.add("안양시");
			vos.add("안성시");
			vos.add("평택시");
			vos.add("용인시");
			vos.add("의정부시");
			vos.add("광명시");
			vos.add("성남시");
		}
		else if(dodo.equals("충북")) {
			vos.add("청주시");
			vos.add("충주시");
			vos.add("괴산군");
			vos.add("제천시");
			vos.add("단양군");
			vos.add("증평군");
			vos.add("옥천군");
			vos.add("영동군");
		}
		else if(dodo.equals("충남")) {
			vos.add("천안시");
			vos.add("아산시");
			vos.add("논산시");
			vos.add("공주시");
			vos.add("부여군");
			vos.add("홍성군");
			vos.add("예산군");
			vos.add("청양군");
		}		
		return vos;
	}

	@Override
	public UserVO getUserSearch(String mid) {
		return user2DAO.getUserSearchVO(mid);
	}

	@Override
	public List<UserVO> getUser2SearchMid(String mid) {
		return user2DAO.getUser2SearchMid(mid);
	}

	@Override
	public int fileUpload(MultipartFile fName, String mid) {
		int res = 0;
		
		// 파일이름에 대한 중복처리
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = mid + "_" + uid + "_" + oFileName;
		
		// 파일복사 처리(서버 메모리에 올라와 있는 파일의 정보를 실제 서버파일 시스템에 저장시킨다.)
		try {
			writeFile(fName, sFileName);
			res=1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	private void writeFile(MultipartFile fName, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName); //저장은 output, 읽기/담아오는 것은 input
		/*
		fos.write(fName.getBytes()); //바이너리로 온 것이 바이트단위로 바뀐다.
		fos.close(); //fileOutputStream을 닫아준다.
		*/
		
		if((fName.getBytes().length) != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	@Override
	public KakaoAddressVO getKakaoAddressSearch(String address) {
		return studyDAO.getKakaoAddressSearch(address);
	}

	@Override
	public void setKaKaoAddressInput(KakaoAddressVO vo) {
		studyDAO.setKaKaoAddressInput(vo);
	}

	@Override
	public List<KakaoAddressVO> getKakaoAddressList() {
		return studyDAO.getKakaoAddressList();
	}

	@Override
	public int setKakaoAddressDelete(String address) {
		return studyDAO.setKakaoAddressDelete(address);
	}

	@Override
	public List<ChartVO> getVisitCount() {
		return studyDAO.getVisitCount();
	}

	@Override
	public String setQrCodeCreate1(String realPath, QrCodeVO vo) {
		String qrCodeName = "";
		String qrCodeName2 = "";
		
		try {
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String strToday = sdf.format(today);
			UUID uid = UUID.randomUUID();
			String strUid = uid.toString().substring(0,2); //날짜와 섞어 쓰기 (rand뉴메릭도똑같음)
			
			qrCodeName = strToday + "_" + vo.getMid() + "_" + vo.getName() + "_" + vo.getEmail() + "_" + strUid; 
			qrCodeName2 = "생성날짜 : " + strToday + "\n아이디 : " + vo.getMid() + "\n성명 : " + vo.getName() + "\n이메일 : " + vo.getEmail(); 
			qrCodeName2 = new String(qrCodeName2.getBytes("UTF-8"), "ISO-8859-1");
			
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs(); // 폴더가 존재하지 않으면 폴더를 생성시켜준다,
			
			//qr코드 만들기
			int qrCodeColor = 0xFF000000; //qr 코드의 글자색 - 검정색
			int qrCodeBackColor = 0xFFFFFF;  //qr 코드의 배경색(바탕색) - 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName2, BarcodeFormat.QR_CODE, 200 , 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor,qrCodeBackColor );
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			//생성된 QR코드 이미지를 그림파일로 만들어낸다.
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		return qrCodeName;
	}

	@Override
	public String setQrCodeCreate2(String realPath, QrCodeVO vo) {
		String qrCodeName = "";
		String qrCodeName2 = "";
		
		try {
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String strToday = sdf.format(today);
			UUID uid = UUID.randomUUID();
			String strUid = uid.toString().substring(0,2); //날짜와 섞어 쓰기 (rand뉴메릭도똑같음)
			
			//qrCodeName = strToday + "_" + vo.getMoveUrl() + "_" + strUid; 
			qrCodeName = strToday + "_" + vo.getMoveUrl().replace(":", "_").replace("/", "_").replace("?", "_") + "_" + strUid; //파일명 특수기호 오류 처리 
			qrCodeName2 = vo.getMoveUrl(); 
			qrCodeName2 = new String(qrCodeName2.getBytes("UTF-8"), "ISO-8859-1");
			
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs(); // 폴더가 존재하지 않으면 폴더를 생성시켜준다,
			
			//qr코드 만들기
			int qrCodeColor = 0xFF000000; //qr 코드의 글자색 - 검정색
			int qrCodeBackColor = 0xFFFFFF;  //qr 코드의 배경색(바탕색) - 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName2, BarcodeFormat.QR_CODE, 200 , 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor,qrCodeBackColor );
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			//생성된 QR코드 이미지를 그림파일로 만들어낸다.
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		return qrCodeName;
	}

	@Override
	public String setQrCodeCreate3(String realPath, QrCodeVO vo) {
		String qrCodeName = "";
		String qrCodeName2 = "";
		
		try {
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String strToday = sdf.format(today);
			//UUID uid = UUID.randomUUID();
			//String strUid = uid.toString().substring(0,2);
			
			qrCodeName = strToday + "_" + vo.getMovieName() + "_" + vo.getMovieDate() + "_" + vo.getMovieTime() + "_" + vo.getMovieAdult() + "_" + vo.getMovieChild() + "_" + vo.getMid(); 
			qrCodeName2 = "구매일자" + strToday + "\n영화제목 : " + vo.getMovieName() + "\n상영일자 : " + vo.getMovieDate() + "\n상영시간 : " + vo.getMovieTime() + "\n성인 : " + vo.getMovieAdult() + "매\n어린이 : " + vo.getMovieChild() + "매\n구매자아이디 : " + vo.getMid(); 
			qrCodeName2 = new String(qrCodeName2.getBytes("UTF-8"), "ISO-8859-1");
			
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs(); // 폴더가 존재하지 않으면 폴더를 생성시켜준다,
			
			//qr코드 만들기
			int qrCodeColor = 0xFF000000; //qr 코드의 글자색 - 검정색
			int qrCodeBackColor = 0xFFFFFF;  //qr 코드의 배경색(바탕색) - 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName2, BarcodeFormat.QR_CODE, 200 , 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor,qrCodeBackColor );
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			//생성된 QR코드 이미지를 그림파일로 만들어낸다.
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		return qrCodeName;
	}

	@Override
	public String setQrCodeCreate4(String realPath, QrCodeVO vo) {
		String qrCodeName = "";
		String qrCodeName2 = "";
		
		try {
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String strToday = sdf.format(today);
			//UUID uid = UUID.randomUUID();
			//String strUid = uid.toString().substring(0,2);
			
			qrCodeName = strToday + "_" + vo.getMovieName() + "_" + vo.getMovieDate() + "_" + vo.getMovieTime() + "_" + vo.getMovieAdult() + "_" + vo.getMovieChild() + "_" + vo.getMid(); 
			qrCodeName2 = "구매일자" + strToday + "\n영화제목 : " + vo.getMovieName() + "\n상영일자 : " + vo.getMovieDate() + "\n상영시간 : " + vo.getMovieTime() + "\n성인 : " + vo.getMovieAdult() + "매\n어린이 : " + vo.getMovieChild() + "매\n구매자아이디 : " + vo.getMid(); 
			qrCodeName2 = new String(qrCodeName2.getBytes("UTF-8"), "ISO-8859-1");
			
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs(); // 폴더가 존재하지 않으면 폴더를 생성시켜준다,
			
			//qr코드 만들기
			int qrCodeColor = 0xFF000000; //qr 코드의 글자색 - 검정색
			int qrCodeBackColor = 0xFFFFFF;  //qr 코드의 배경색(바탕색) - 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName2, BarcodeFormat.QR_CODE, 200 , 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor,qrCodeBackColor );
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			//생성된 QR코드 이미지를 그림파일로 만들어낸다.
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
			
			
			// QR코드 생성후 정보를 DB에 저장시켜준다.
			vo.setPublicShow(strToday);
			vo.setQrCodeName(qrCodeName); 
			studyDAO.setQrCodeCreate(vo);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		return qrCodeName;
	}

	@Override
	public QrCodeVO getQrCodeSearch(String qrCode) {
		return studyDAO.getQrCodeSearch(qrCode);
	}

	@Override
	public int setThumbnailCreate(MultipartFile file) {
		int res = 0;
		
		try {
			// 중복 이름 피하기
			UUID uid = UUID.randomUUID();
			String strUid = uid.toString(); 
			String sFileName = strUid.substring(strUid.lastIndexOf("-")+1) + "" + file.getOriginalFilename();
			
			// 지정된 경로에 원본 이미지 저장하기
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/");
			File realFileName = new File(realPath + sFileName);
			file.transferTo(realFileName);	//원본 이미지 저장하기
			
			// 썸네일 이미지 저장하기
			String thumbnailSaveName = realPath + "s_" + sFileName;
			File thumbnailFile = new File(thumbnailSaveName);
		
			int width = 160;
			int height = 120;
			Thumbnailator.createThumbnail(realFileName, thumbnailFile, width, height); //1.원본이름 2.썸네일이름 3.폭 4.높이

			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<TransactionVO> getTransactionList() {
		return studyDAO.getTransactionList();
	}

	@Override
	public void setTransactionUser1Input(TransactionVO vo) {
		studyDAO.setTransactionUser1Input(vo);
	}

	@Override
	public void setTransactionUser2Input(TransactionVO vo) {
		studyDAO.setTransactionUser2Input(vo);
	}

	@Override
	public List<TransactionVO> getTransactionList2() {
		return studyDAO.getTransactionList2();
	}

	@Transactional
	@Override
	public void setTransactionUserInput(TransactionVO vo) {
		studyDAO.setTransactionUserInput(vo);
	}

	@Override
	public void setTransactionUserInput2(String mid, String name, int age, String address, String job) {
		studyDAO.setTransactionUserInput2(mid, name, age, address, job);
	}
	
}

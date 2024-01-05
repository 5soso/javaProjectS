package com.spring.javaProjectS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS.vo.ChartVO;
import com.spring.javaProjectS.vo.KakaoAddressVO;
import com.spring.javaProjectS.vo.QrCodeVO;
import com.spring.javaProjectS.vo.TransactionVO;
import com.spring.javaProjectS.vo.UserVO;

public interface StudyService {

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public UserVO getUserSearch(String mid);

	public List<UserVO> getUser2SearchMid(String mid);

	public int fileUpload(MultipartFile fName, String mid);

	public KakaoAddressVO getKakaoAddressSearch(String address);

	public void setKaKaoAddressInput(KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public int setKakaoAddressDelete(String address);

	public List<ChartVO> getVisitCount();

	public String setQrCodeCreate1(String realPath, QrCodeVO vo);

	public String setQrCodeCreate2(String realPath, QrCodeVO vo);

	public String setQrCodeCreate3(String realPath, QrCodeVO vo);

	public String setQrCodeCreate4(String realPath, QrCodeVO vo);

	public QrCodeVO getQrCodeSearch(String qrCode);

	public int setThumbnailCreate(MultipartFile file);

	public List<TransactionVO> getTransactionList();

	public void setTransactionUser1Input(TransactionVO vo);

	public void setTransactionUser2Input(TransactionVO vo);

	public List<TransactionVO> getTransactionList2();

	public void setTransactionUserInput(TransactionVO vo);

	public void setTransactionUserInput2(String mid, String name, int age, String address, String job);
}

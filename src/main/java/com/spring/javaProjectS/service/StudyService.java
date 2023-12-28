package com.spring.javaProjectS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS.vo.ChartVO;
import com.spring.javaProjectS.vo.KakaoAddressVO;
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
}

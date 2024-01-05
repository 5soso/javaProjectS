package com.spring.javaProjectS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS.vo.ChartVO;
import com.spring.javaProjectS.vo.KakaoAddressVO;
import com.spring.javaProjectS.vo.QrCodeVO;
import com.spring.javaProjectS.vo.TransactionVO;

public interface StudyDAO {

	public KakaoAddressVO getKakaoAddressSearch(@Param("address") String address);

	public void setKaKaoAddressInput(@Param("vo") KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

	public int setKakaoAddressDelete(@Param("address") String address);

	public List<ChartVO> getVisitCount();

	public void setQrCodeCreate(@Param("vo") QrCodeVO vo);

	public QrCodeVO getQrCodeSearch(@Param("qrCode") String qrCode);

	public List<TransactionVO> getTransactionList();

	public void setTransactionUser1Input(@Param("vo") TransactionVO vo);

	public void setTransactionUser2Input(@Param("vo") TransactionVO vo);

	public List<TransactionVO> getTransactionList2();

	public void setTransactionUserInput(@Param("vo") TransactionVO vo);

	public void setTransactionUserInput2(@Param("mid") String mid, @Param("name") String name, @Param("age") int age, @Param("address") String address, @Param("job") String job);

}

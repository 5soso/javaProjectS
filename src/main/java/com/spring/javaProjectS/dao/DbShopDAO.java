package com.spring.javaProjectS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS.vo.DbBaesongVO;
import com.spring.javaProjectS.vo.DbCartVO;
import com.spring.javaProjectS.vo.DbOptionVO;
import com.spring.javaProjectS.vo.DbOrderVO;
import com.spring.javaProjectS.vo.DbProductVO;

@Mapper
public interface DbShopDAO {

	public DbProductVO getCategoryMainOne(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMainName") String categoryMainName);

	public int setCategoryMainInput(@Param("vo") DbProductVO vo);

	public List<DbProductVO> getCategoryMain();

	public DbProductVO getCategoryMiddleOne(@Param("vo") DbProductVO vo);

	public int setCategoryMainDelete(@Param("categoryMainCode") String categoryMainCode);

	public int setCategoryMiddleInput(@Param("vo") DbProductVO vo);

	public List<DbProductVO> getCategoryMiddle();

	public DbProductVO getCategorySubOne(@Param("vo") DbProductVO vo);

	public int setCategoryMiddleDelete(@Param("categoryMiddleCode") String categoryMiddleCode);

	public int setCategorySubInput(@Param("vo") DbProductVO vo);

	public List<DbProductVO> getCategoryMiddleName(@Param("categoryMainCode") String categoryMainCode);

	public List<DbProductVO> getCategorySub();

	public List<DbProductVO> getCategorySubName(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMiddleCode") String categoryMiddleCode);

	public DbProductVO getCategoryProductName(@Param("vo") DbProductVO vo);

	public int setCategorySubDelete(@Param("categorySubCode") String categorySubCode);

	public DbProductVO getProductMaxIdx();

	public int setDbProductInput(@Param("vo") DbProductVO vo);

	public List<DbProductVO> getSubTitle();
	
	public List<DbProductVO> getDbShopList(@Param("part") String part);

	public DbProductVO getDbShopProduct(@Param("idx") int idx);

	public List<DbProductVO> getCategoryProductNameAjax(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMiddleCode") String categoryMiddleCode, @Param("categorySubCode") String categorySubCode);

	public DbProductVO getProductInfor(@Param("productName") String productName);

	public List<DbOptionVO> getOptionList(@Param("productIdx") int productIdx);

	public int getOptionSame(@Param("productIdx") int productIdx, @Param("optionName") String optionName);

	public int setDbOptionInput(@Param("vo") DbOptionVO vo);

	public List<DbOptionVO> getDbShopOption(@Param("idx") int idx);

	public int setOptionDelete(@Param("idx") int idx);

	public List<DbCartVO> getDbCartList(@Param("mid") String mid);

	public DbCartVO getDbCartProductOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName, @Param("mid") String mid);

	public int dbShopCartUpdate(@Param("vo") DbCartVO vo);

	public int dbShopCartInput(@Param("vo") DbCartVO vo);

	public int dbCartDelete(@Param("idx") int idx);

	public DbOrderVO getOrderMaxIdx();

	public DbCartVO getCartIdx(@Param("idx") int idx);

	public void setDbOrder(@Param("vo") DbOrderVO vo);

	public void setDbCartDeleteAll(@Param("cartIdx") int cartIdx);

	public void setDbBaesong(@Param("baesongVO") DbBaesongVO baesongVO);

	public void setMemberPointPlus(@Param("point") int point, @Param("mid") String mid);

	public int getTotalBaesongOrder(@Param("orderIdx") String orderIdx);

	public List<DbBaesongVO> getOrderBaesong(@Param("orderIdx") String orderIdx);

}

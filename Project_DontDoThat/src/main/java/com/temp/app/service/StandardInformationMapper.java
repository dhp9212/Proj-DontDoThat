package com.temp.app.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.app.model.CityDTO;
import com.temp.app.model.CountryDTO;
import com.temp.app.model.CurrencyDTO;
import com.temp.app.model.LanguageDTO;

@Service
public class StandardInformationMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<CountryDTO> selectCountry(){
		return sqlSession.selectList("selectCountry");
	}
	
	public List<CityDTO> selectCity(){
		return sqlSession.selectList("selectCity");
	}
	
	public List<CurrencyDTO> selectCurrency(){
		return sqlSession.selectList("selectCurrency");
	}
	
	public List<LanguageDTO> selectLanguage(){
		return sqlSession.selectList("selectLanguage");
	}
}

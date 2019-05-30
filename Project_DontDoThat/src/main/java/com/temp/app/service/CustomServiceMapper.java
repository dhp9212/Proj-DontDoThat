package com.temp.app.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.app.model.QA_AnswerDTO;
import com.temp.app.model.QA_SubCateDTO;

@Service
public class CustomServiceMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<String> getMainCategory(){
		return sqlSession.selectList("mainCateList");
	}
	public List<QA_SubCateDTO> getSubCategory(String maincate){
		return sqlSession.selectList("subCateList", maincate); 
	}
	public int insertMainCategory(String maincate) {
		return sqlSession.insert("insertMainCate", maincate);
	}
	public int insertSubCategory(String maincate, String subcate) {
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("maincate", maincate);
		hm.put("subcate", subcate);
		return sqlSession.insert("insertSubCate", hm);
	}
	public int deleteMainCate(String maincate) {
		return sqlSession.delete("deleteMainCate", maincate);
	}
	public int deleteMainCate1(String maincate) {
		return sqlSession.delete("deleteMainCate1", maincate);
	}
	public int deleteSubCate(String no) {
		return sqlSession.delete("deleteSubCate", no);
	}
	//´äº¯
	public List<QA_AnswerDTO> getAnswer(int subcate){
		return sqlSession.selectList("getAnswer", subcate);
	}
	public int inputAnswer(QA_AnswerDTO dto) {
		return sqlSession.insert("inputAnswer", dto);
	}
	public int deleteAnswer(int no) {
		return sqlSession.delete("deleteAnswer", no);
	}
}

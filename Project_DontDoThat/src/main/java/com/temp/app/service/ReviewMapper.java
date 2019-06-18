package com.temp.app.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.app.model.GradeDTO;
import com.temp.app.model.ReviewDTO;
import com.temp.app.model.ReviewGradeDTO;

@Service
public class ReviewMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<ReviewGradeDTO> listReview(int accommodation){
		return sqlSession.selectList("listReview", accommodation);
	}
	public List<ReviewDTO> list10Review(int accommodation){
		return sqlSession.selectList("list10Review", accommodation);
	}
	public int countReview(int accommodation) {
		return sqlSession.selectOne("countReview", accommodation);
	}
	public GradeDTO averageReview(int accommodation){
		return sqlSession.selectOne("averageReview", accommodation);
	}
	public int insertReview(ReviewDTO dto) { 
	sqlSession.insert("insertReview", dto);
		return dto.getNum();
	}
	public int insertGrade(GradeDTO dto) {
	return sqlSession.insert("insertGrade", dto);
	}
}

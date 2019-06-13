package com.temp.app.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.app.model.CategoryAccomodationDTO;
import com.temp.app.model.FacilityDTO;
import com.temp.app.model.RoomInfoDTO;

@Service
public class CategoryMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<CategoryAccomodationDTO> selectCategodyAccomodation(){
		return sqlSession.selectList("selectCategoryAccomodation");
	}
	
	public List<RoomInfoDTO> selectCategoryRoom(){
		return sqlSession.selectList("selectRoomCategory");
	}
	
	public List<String> selectCardList(){
		  return sqlSession.selectList("selectCardList");
	}
	
	public List<FacilityDTO> selectFacility(){
		return sqlSession.selectList("selectFacility");
	}
	
	public CategoryAccomodationDTO getCategoryAccomodation(int key) {
		return sqlSession.selectOne("getCategoryAccomodation", key);
	}
}

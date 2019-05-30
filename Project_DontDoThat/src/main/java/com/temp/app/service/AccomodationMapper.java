package com.temp.app.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.app.model.AccomodationDTO;
import com.temp.app.model.RoomDTO;

@Service
public class AccomodationMapper {
	@Autowired
	private SqlSession sqlSession;

	//숙소등록
	public int insertAccomodation(AccomodationDTO dto) {
		sqlSession.insert("insertAccomodation", dto);
		return dto.getNum();
	}
	//방 여려개 등록
	public void insertRoom(List<RoomDTO> list) {
		for(RoomDTO dto : list) {
			sqlSession.insert("insertRoom", dto);
		}
	}
	//방 하나 등록
	public void insertRoom(RoomDTO dto) {
		sqlSession.insert("insertRoom", dto);
	}
}

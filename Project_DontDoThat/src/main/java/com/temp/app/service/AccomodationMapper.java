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

	//���ҵ��
	public int insertAccomodation(AccomodationDTO dto) {
		sqlSession.insert("insertAccomodation", dto);
		return dto.getNum();
	}
	//�� ������ ���
	public void insertRoom(List<RoomDTO> list) {
		for(RoomDTO dto : list) {
			sqlSession.insert("insertRoom", dto);
		}
	}
	//�� �ϳ� ���
	public void insertRoom(RoomDTO dto) {
		sqlSession.insert("insertRoom", dto);
	}
}

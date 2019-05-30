package com.temp.app.service;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

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
	
	//�� ������Ʈ
	public void updateRoom(RoomDTO dto) {
		sqlSession.update("updateRoom", dto);
	}
	
	//�̸��� �´� ���� ��������
	public Hashtable<String, AccomodationDTO> getAccomodation(String name){
		List<AccomodationDTO> list = sqlSession.selectList("getAccomodation", name);
		Hashtable<String, AccomodationDTO> table = new Hashtable<String, AccomodationDTO>();
		for(AccomodationDTO dto : list) {
			table.put(String.valueOf(dto.getNum()), dto);
		}
		return table;
	}
	//�� ���� ��������
	public Hashtable<String, RoomDTO> getRoomList(String num){
		List<RoomDTO> list = sqlSession.selectList("getRoomList", num);
		Hashtable<String, RoomDTO> table = new Hashtable<String, RoomDTO>();
		for(RoomDTO dto : list) {
			table.put(String.valueOf(dto.getNum()), dto);
		}
		return table;
	}
	//������Ʈ ���ҽü�
	public void updateAccomodation_facility(String accomodation_num, String accomodation_facility) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("accomodation_facility", accomodation_facility);
		sqlSession.update("updateAccomodation_facility", map);
	}
	//������Ʈ ����
	public void updateContent(String accomodation_num, String content) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("content", content);
		sqlSession.update("updateContent", map);
	}
	//������Ʈ ��å
	public void updatePolicy(String accomodation_num, String policy) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("policy", policy);
		sqlSession.update("updatePolicy", map);
	}
}

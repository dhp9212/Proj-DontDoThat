package com.temp.app.service;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Service;

import com.temp.app.model.AccomodationDTO;
import com.temp.app.model.ReservationDTO;
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
	public Hashtable<String, AccomodationDTO> getAccomodation(int num){
		Hashtable<String, AccomodationDTO> table = new Hashtable<String, AccomodationDTO>();
		try {
			List<AccomodationDTO> list = sqlSession.selectList("getAccomodation", num);
			for(AccomodationDTO dto : list) {
				table.put(String.valueOf(dto.getNum()), dto);
			}
		}catch(UncategorizedSQLException e) {
			System.out.println("no data");
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
	public void updateNearby(String accomodation_num, String nearby) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("nearby", nearby);
		sqlSession.update("updateNearby", map);
	}
	public void updateImage(String accomodation_num, String image) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("image", image);
		sqlSession.update("updateImage", map);
	}
	public void updateRoom_image(String room_num, String room_image) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("room_num", room_num);
		map.put("room_image", room_image);
		sqlSession.update("updateRoom_image", map);
	}
	//���� ���
		public List<AccomodationDTO> listAccomodation() {
			Map<String, Integer> map = new HashMap<String, Integer>();
			return sqlSession.selectList("listAccomodation", map);
		}
		//���� ���
		public int insertReservation(ReservationDTO dto) {
			int res = sqlSession.insert("insertReservation", dto);
			return res;
		}
		public RoomDTO getRoom(int num) {
			RoomDTO dto = sqlSession.selectOne("getRoom", num);
			return dto;
		}
		
}

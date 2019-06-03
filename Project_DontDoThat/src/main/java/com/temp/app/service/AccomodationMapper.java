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
	
	//방 업데이트
	public void updateRoom(RoomDTO dto) {
		sqlSession.update("updateRoom", dto);
	}
	
	//이름에 맞는 숙소 가져오기
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
	//방 정보 가져오기
	public Hashtable<String, RoomDTO> getRoomList(String num){
		List<RoomDTO> list = sqlSession.selectList("getRoomList", num);
		Hashtable<String, RoomDTO> table = new Hashtable<String, RoomDTO>();
		for(RoomDTO dto : list) {
			table.put(String.valueOf(dto.getNum()), dto);
		}
		return table;
	}
	//업데이트 숙소시설
	public void updateAccomodation_facility(String accomodation_num, String accomodation_facility) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("accomodation_facility", accomodation_facility);
		sqlSession.update("updateAccomodation_facility", map);
	}
	//업데이트 내용
	public void updateContent(String accomodation_num, String content) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("content", content);
		sqlSession.update("updateContent", map);
	}
	//업데이트 정책
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
	//숙소 목록
		public List<AccomodationDTO> listAccomodation() {
			Map<String, Integer> map = new HashMap<String, Integer>();
			return sqlSession.selectList("listAccomodation", map);
		}
		//예약 등록
		public int insertReservation(ReservationDTO dto) {
			int res = sqlSession.insert("insertReservation", dto);
			return res;
		}
		public RoomDTO getRoom(int num) {
			RoomDTO dto = sqlSession.selectOne("getRoom", num);
			return dto;
		}
		
}

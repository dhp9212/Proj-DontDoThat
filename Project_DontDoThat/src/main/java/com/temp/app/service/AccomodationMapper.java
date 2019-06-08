package com.temp.app.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.temp.app.model.AccomodationDTO;
import com.temp.app.model.ReservationDTO;
import com.temp.app.model.RoomDTO;

@Service
public class AccomodationMapper {
	@Autowired
	private SqlSession sqlSession;

	public int insertAccomodation(AccomodationDTO dto) {
		sqlSession.insert("insertAccomodation", dto);
		return dto.getNum();
	}
	public void insertRoom(List<RoomDTO> list) {
		for(RoomDTO dto : list) {
			sqlSession.insert("insertRoom", dto);
		}
	}
	public void insertRoom(RoomDTO dto) {
		sqlSession.insert("insertRoom", dto);
	}
	
	public void updateRoom(RoomDTO dto) {
		sqlSession.update("updateRoom", dto);
	}
	
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
	//유저에 맞는 숙소 가져오기
	public Hashtable<String, RoomDTO> getRoomList(String num){
		List<RoomDTO> list = sqlSession.selectList("getRoomList", num);
		Hashtable<String, RoomDTO> table = new Hashtable<String, RoomDTO>();
		for(RoomDTO dto : list) {
			table.put(String.valueOf(dto.getNum()), dto);
		}
		return table;
	}
	//숙소 시설 업데이트
	public void updateAccomodation_facility(String accomodation_num, String accomodation_facility) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("accomodation_facility", accomodation_facility);
		sqlSession.update("updateAccomodation_facility", map);
	}
	//숙소 내용 업데이트
	public void updateContent(String accomodation_num, String content) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("content", content);
		sqlSession.update("updateContent", map);
	}
	//숙소 정책 업데이트
	public void updatePolicy(String accomodation_num, Map<String, String> map) {
		sqlSession.update("updatePolicy", map);
	}
	//주변시설
	public void updateNearby(String accomodation_num, String nearby) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("nearby", nearby);
		sqlSession.update("updateNearby", map);
	}
	//숙소 이미지 변경
	public void updateImage(MultipartHttpServletRequest mr) {
		HttpSession session = mr.getSession();
		String accomodation_image = mr.getParameter("accomodation_image");
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		//이번 등록동안 사용할 카운트
		int count = 0;
		String upPath = session.getServletContext().getRealPath("resources/img");
		List<MultipartFile> accomodatation_files = mr.getFiles("accomodation_files");
		String image = "";
		if(accomodatation_files.size()!=0) {
			for(MultipartFile mf : accomodatation_files) {
				//파일이 이미지 타입이 아닌경우 다음파일로
				if(!mf.getContentType().substring(0, 5).equals("image")) continue;
				//파라메터 값 분석후 image값 넣음 + 파일쓰기
				image = imageCheck(mf, accomodation_image, upPath, image, count);
			}	
		}else {
			//만약 변경사항이 없는경우(지우기만 한 경우)
			image = accomodation_image;
		}
		//sql전송(updateImage)
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("image", image);
		sqlSession.update("updateImage", map);
		//서버 테이블에 등록(Accomodation)
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO adto = table.get(accomodation_num);
		adto.setImage(image);
		table.put(accomodation_num, adto);
		//방 등록 시작
		updateRoom_image(mr, count);
	}
	//방 이미지 변경
	public void updateRoom_image(MultipartHttpServletRequest mr, int count) {
		HttpSession session = mr.getSession();
		String upPath = session.getServletContext().getRealPath("resources/img");
		Hashtable<String, RoomDTO> room_list = (Hashtable)session.getAttribute("room_list");
		Enumeration<String> key = room_list.keys();
		while(key.hasMoreElements()) {
			String room_num = key.nextElement();
			String room_image = mr.getParameter(room_num + "room_image");
			List<MultipartFile> room_files = mr.getFiles(room_num + "room_files");
			String image = "";
			if(room_files.size()!=0) {
				for(MultipartFile mf : room_files) {
					//파라메터 값 분석후 image값 넣음  + 파일쓰기
					image = imageCheck(mf, room_image, upPath, image, count);
				}
			}else {
				//만약 변경사항이 없는경우(지우기만 한 경우)
				image = room_image;
			}
			//sql전송(updateRoom_image)
			Map<String, String> map = new HashMap<String, String>();
			map.put("room_num", room_num);
			map.put("room_image", image);
			sqlSession.update("updateRoom_image", map);
			//서버 테이블에 등록(Room)
			RoomDTO rdto = room_list.get(room_num);
			rdto.setRoom_image(image);
			room_list.put(room_num, rdto);
		}
	}
	//파라메터값과 현재파일값 분석 및 저장
	private String imageCheck(MultipartFile mf, String target_image, String upPath, String save_name, int count) {
		String[] images = target_image.split(",");
		for(String image : images) {
			count++;
			//파일이름이 여기 이름과 같은지 비교
			if(mf.getOriginalFilename().equals(image)) {
				//만약 파일이 이미 있다면  이름을 적어두고 다음파일로
				if(new File(upPath, image).exists()) {
					if(save_name=="") save_name = image;
					else save_name += "," + image;
					continue;
				}else {
					//없는 파일이라면 시간 + count + 확장자 저장
					String extension = image.substring(image.lastIndexOf('.'));
					String time = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + count + extension;
					File file = new File(upPath, time);
					if(save_name=="") save_name = time;
					else save_name += "," + time;
					try {
						mf.transferTo(file);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}else continue;
		}
		return save_name;
	}
	//���� ���
	public List<AccomodationDTO> listAccomodation(String input_place, String start_date, String end_date, String people, int startRow, int endRow){
		HashMap<String, String> map = new HashMap<String, String>();
		String condition = "";
		if(input_place != null && !input_place.equals("")) {
			condition += " where country = '" + input_place + "' ";
			if(start_date != null && !start_date.equals("")) {
				condition += " and checkin_date <= " + start_date;
				condition += " and checkout_date >= " + end_date;
			}
		}
		String startRowStr = Integer.toString(startRow);
		String endRowStr = Integer.toString(endRow);
		map.put("condition", condition);
		map.put("startRow", startRowStr);
		map.put("endRow", endRowStr);
		return sqlSession.selectList("listAccomodation", map);
	}
	//���� ��ü ���
	public List<AccomodationDTO> listAccomodation(int startRow, int endRow) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sqlSession.selectList("listAccomodationAll");
	}
	//���� ���
	public int insertReservation(ReservationDTO dto) {
		return sqlSession.insert("insertReservation", dto);
	}
	//���� ���
	public int deleteReservation(int num) {
		return sqlSession.delete("deleteReservation", num);
	}
	//�� �ϳ� ���� ��������
	public RoomDTO getRoom(int num) {
		return sqlSession.selectOne("getRoom", num);
	}
	//���� ���� ��������
	public AccomodationDTO getAccomodationInfo(int num) {
		return sqlSession.selectOne("getAccomodationInfo", num);
	}
	//���� ���� ��������
	public int getCount() {
		return sqlSession.selectOne("getCount");
	}
}

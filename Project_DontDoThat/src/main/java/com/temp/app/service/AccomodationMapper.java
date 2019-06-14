package com.temp.app.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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

    public int insertAccomodation(MultipartHttpServletRequest mr, AccomodationDTO aDTO) {
        HttpSession session = mr.getSession();
        String upPath = session.getServletContext().getRealPath("resources/img");
        String accomodation_image = mr.getParameter("image");
        List<MultipartFile> accomodatation_files = mr.getFiles("accomodation_files");
        
        //이번 등록동안 사용할 맵, 카운터
        Integer count = 0;
        Hashtable<Integer, String> change_index = new Hashtable<Integer, String>();
        String image = "";
        
        for(MultipartFile mf : accomodatation_files) {
            //파일이 이미지 타입이 아닌경우 다음파일로
            if(!mf.getContentType().substring(0, 5).equals("image")) continue;
            //파라메터 값 분석후 바뀐 값 맵에 저장  + 파일쓰기
            count = count+1;
            imageCheck(mf, accomodation_image, upPath, count, change_index);
        }
        Enumeration<Integer> change_index_key = change_index.keys();
        ArrayList<String> list = new ArrayList<String>(Arrays.asList(accomodation_image.split(",")));
        while(change_index_key.hasMoreElements()) {
            Integer index = change_index_key.nextElement();
            list.set(index, change_index.get(index));
        }
        for(String str : list) {
            if(image.equals("")) image = str;
            else image += "," + str;
        }
        aDTO.setImage(image);
        aDTO.setAddress(mr.getParameter("roadname") + mr.getParameter("detail"));
        
        sqlSession.insert("insertAccomodation", aDTO);
        return aDTO.getNum();
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
	//
	public Hashtable<String, RoomDTO> getRoomList(String num){
		List<RoomDTO> list = sqlSession.selectList("getRoomList", num);
		Hashtable<String, RoomDTO> table = new Hashtable<String, RoomDTO>();
		for(RoomDTO dto : list) {
			table.put(String.valueOf(dto.getNum()), dto);
		}
		return table;
	}
	public List<RoomDTO> getRoomList(int accomodation_num){
		String num = accomodation_num + "";
		return sqlSession.selectList("getRoomList", num);
	}
	//
	public void updateAccomodation_facility(String accomodation_num, String accomodation_facility) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("accomodation_facility", accomodation_facility);
		sqlSession.update("updateAccomodation_facility", map);
	}
	//
	public void updateContent(String accomodation_num, String content) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("content", content);
		sqlSession.update("updateContent", map);
	}
	//
	public void updatePolicy(String accomodation_num, Map<String, String> map) {
		sqlSession.update("updatePolicy", map);
	}
	//
	public void updateNearby(String accomodation_num, String nearby) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("nearby", nearby);
		sqlSession.update("updateNearby", map);
	}
	//
	public void updateImage(MultipartHttpServletRequest mr) {
		HttpSession session = mr.getSession();
		String accomodation_image = mr.getParameter("accomodation_image");
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		//
		Integer count = 0;
		Hashtable<Integer, String> change_index = new Hashtable<Integer, String>();
		
		String upPath = session.getServletContext().getRealPath("resources/img");
		List<MultipartFile> accomodatation_files = mr.getFiles("accomodation_files");
		String image = "";
		if(accomodatation_files.size()!=0) {
			for(MultipartFile mf : accomodatation_files) {
				//
				if(!mf.getContentType().substring(0, 5).equals("image")) continue;
				//
				count = count+1;
				imageCheck(mf, accomodation_image, upPath, count, change_index);
			}
			if(change_index.size()!=0) {
				Enumeration<Integer> change_index_key = change_index.keys();
				ArrayList<String> list = new ArrayList<String>(Arrays.asList(accomodation_image.split(",")));
				while(change_index_key.hasMoreElements()) {
					Integer index = change_index_key.nextElement();
					list.set(index, change_index.get(index));
				}
				for(String str : list) {
					if(image.equals("")) image = str;
					else image += "," + str;
				}
			}
		}else {
			//
			image = accomodation_image;
		}
		//
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("image", image);
		sqlSession.update("updateImage", map);
		//
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO adto = table.get(accomodation_num);
		adto.setImage(image);
		table.put(accomodation_num, adto);
		//
		updateRoom_image(mr, count);
	}
	//
	public void updateRoom_image(MultipartHttpServletRequest mr, Integer count) {
		HttpSession session = mr.getSession();
		String upPath = session.getServletContext().getRealPath("resources/img");
		Hashtable<String, RoomDTO> room_list = (Hashtable)session.getAttribute("room_list");
		Enumeration<String> key = room_list.keys();
		while(key.hasMoreElements()) {
			String room_num = key.nextElement();
			String room_image = mr.getParameter(room_num + "room_image");
			List<MultipartFile> room_files = mr.getFiles(room_num + "room_files");
			//
			Hashtable<Integer, String> change_index = new Hashtable<Integer, String>();
			count = count+100;
			String image = "";
			if(room_files.size()!=0) {
				for(MultipartFile mf : room_files) {
					//
					if(!mf.getContentType().substring(0, 5).equals("image")) continue;
					//
					count = count+1;
					imageCheck(mf, room_image, upPath, count, change_index);
				}
				if(change_index.size()!=0) {
					Enumeration<Integer> change_index_key = change_index.keys();
					ArrayList<String> list = new ArrayList<String>(Arrays.asList(room_image.split(",")));
					while(change_index_key.hasMoreElements()) {
						Integer index = change_index_key.nextElement();
						list.set(index, change_index.get(index));
					}
					for(String str : list) {
						if(image.equals("")) image = str;
						else image += "," + str;
					}
				}
			}else {
				//
				image = room_image;
			}
			//
			Map<String, String> map = new HashMap<String, String>();
			map.put("room_num", room_num);
			map.put("room_image", image);
			sqlSession.update("updateRoom_image", map);
			//
			RoomDTO rdto = room_list.get(room_num);
			rdto.setRoom_image(image);
			room_list.put(room_num, rdto);
		}
	}
	//
	private synchronized void imageCheck(MultipartFile mf, String target_image, String upPath, Integer count, Hashtable<Integer, String> change_index) {
		String[] images = target_image.split(",");
		for(int i=0; i<images.length; ++i) {
			String image = images[i];
			//
			boolean check = false;
			String filename = mf.getOriginalFilename();
			if(filename.equals(image)) {
				Enumeration<Integer> change_index_key = change_index.keys();
				while(change_index_key.hasMoreElements()) {
					Integer index = change_index_key.nextElement();
					if(i==index) check = true;
				}
				if(check) continue;
				//
				if(!new File(upPath, image).exists()) {
					count = count+1;
					//
					String extension = image.substring(image.lastIndexOf('.'));
					String time = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + count + extension;
					File file = new File(upPath, time);
					try {
						mf.transferTo(file);
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					change_index.put(i, time);
					return;
				}
			}else continue;
		}
	}
	//
	public List<AccomodationDTO> listAccomodation(String input_place, String start_date, String end_date, int startRow, int endRow){
		HashMap<String, String> map = new HashMap<String, String>();
		String startRowStr = Integer.toString(startRow);
		String endRowStr = Integer.toString(endRow);
		map.put("startRow", startRowStr);
		map.put("endRow", endRowStr);
		map.put("input_place", input_place);
		map.put("input_place_city", input_place);
		map.put("start_date", start_date);
		map.put("end_date", end_date);
		List<AccomodationDTO> ret = sqlSession.selectList("listAccomodation", map);
		return ret;
	}
	//
	public List<AccomodationDTO> listAccomodation(int startRow, int endRow) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sqlSession.selectList("listAccomodationAll");
	}
	//
	public int insertReservation(ReservationDTO dto) {
		return sqlSession.insert("insertReservation", dto);
	}
	//
	public int deleteReservation(int num) {
		return sqlSession.delete("deleteReservation", num);
	}
	//
	public RoomDTO getRoom(int num) {
		return sqlSession.selectOne("getRoom", num);
	}
	//
	public AccomodationDTO getAccomodationInfo(int num) {
		return sqlSession.selectOne("getAccomodationInfo", num);
	}
    //숙소 갯수 가져오기
    public int getCount(String input_place, String start_date, String end_date) {
        HashMap<String, String> map = new HashMap<String, String>();
        System.out.println(input_place);
        map.put("input_place", input_place);
		map.put("input_place_city", input_place);
        map.put("start_date", start_date);
        map.put("end_date", end_date);
        System.out.println(map.get("input_place"));
        System.out.println(map.get("input_place_city"));
        return sqlSession.selectOne("getCount", map);
    }
}

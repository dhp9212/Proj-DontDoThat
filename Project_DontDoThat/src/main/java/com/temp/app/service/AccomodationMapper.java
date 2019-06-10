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
	//�쑀���뿉 留욌뒗 �닕�냼 媛��졇�삤湲�
	public Hashtable<String, RoomDTO> getRoomList(String num){
		List<RoomDTO> list = sqlSession.selectList("getRoomList", num);
		Hashtable<String, RoomDTO> table = new Hashtable<String, RoomDTO>();
		for(RoomDTO dto : list) {
			table.put(String.valueOf(dto.getNum()), dto);
		}
		return table;
	}
	//�닕�냼 �떆�꽕 �뾽�뜲�씠�듃
	public void updateAccomodation_facility(String accomodation_num, String accomodation_facility) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("accomodation_facility", accomodation_facility);
		sqlSession.update("updateAccomodation_facility", map);
	}
	//�닕�냼 �궡�슜 �뾽�뜲�씠�듃
	public void updateContent(String accomodation_num, String content) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("content", content);
		sqlSession.update("updateContent", map);
	}
	//�닕�냼 �젙梨� �뾽�뜲�씠�듃
	public void updatePolicy(String accomodation_num, Map<String, String> map) {
		sqlSession.update("updatePolicy", map);
	}
	//二쇰��떆�꽕
	public void updateNearby(String accomodation_num, String nearby) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("nearby", nearby);
		sqlSession.update("updateNearby", map);
	}
	//�닕�냼 �씠誘몄� 蹂�寃�
	public void updateImage(MultipartHttpServletRequest mr) {
		HttpSession session = mr.getSession();
		String accomodation_image = mr.getParameter("accomodation_image");
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		//�씠踰� �벑濡앸룞�븞 �궗�슜�븷 留�, 移댁슫�꽣
		Integer count = 0;
		Hashtable<Integer, String> change_index = new Hashtable<Integer, String>();
		
		String upPath = session.getServletContext().getRealPath("resources/img");
		List<MultipartFile> accomodatation_files = mr.getFiles("accomodation_files");
		String image = "";
		if(accomodatation_files.size()!=0) {
			for(MultipartFile mf : accomodatation_files) {
				//�뙆�씪�씠 �씠誘몄� ���엯�씠 �븘�땶寃쎌슦 �떎�쓬�뙆�씪濡�
				if(!mf.getContentType().substring(0, 5).equals("image")) continue;
				//�뙆�씪硫뷀꽣 媛� 遺꾩꽍�썑 諛붾�� 媛� 留듭뿉 ���옣  + �뙆�씪�벐湲�
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
			//留뚯빟 蹂�寃쎌궗�빆�씠 �뾾�뒗寃쎌슦(吏��슦湲곕쭔 �븳 寃쎌슦)
			image = accomodation_image;
		}
		//sql�쟾�넚(updateImage)
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("image", image);
		sqlSession.update("updateImage", map);
		//�꽌踰� �뀒�씠釉붿뿉 �벑濡�(Accomodation)
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO adto = table.get(accomodation_num);
		adto.setImage(image);
		table.put(accomodation_num, adto);
		//諛� �벑濡� �떆�옉
		updateRoom_image(mr, count);
	}
	//諛� �씠誘몄� 蹂�寃�
	public void updateRoom_image(MultipartHttpServletRequest mr, Integer count) {
		HttpSession session = mr.getSession();
		String upPath = session.getServletContext().getRealPath("resources/img");
		Hashtable<String, RoomDTO> room_list = (Hashtable)session.getAttribute("room_list");
		Enumeration<String> key = room_list.keys();
		while(key.hasMoreElements()) {
			String room_num = key.nextElement();
			String room_image = mr.getParameter(room_num + "room_image");
			List<MultipartFile> room_files = mr.getFiles(room_num + "room_files");
			//�씠踰� �벑濡앸룞�븞 �궗�슜�븷 留�, 移댁슫�꽣
			Hashtable<Integer, String> change_index = new Hashtable<Integer, String>();
			count = count+100;
			String image = "";
			if(room_files.size()!=0) {
				for(MultipartFile mf : room_files) {
					//�뙆�씪�씠 �씠誘몄� ���엯�씠 �븘�땶寃쎌슦 �떎�쓬�뙆�씪濡�
					if(!mf.getContentType().substring(0, 5).equals("image")) continue;
					//�뙆�씪硫뷀꽣 媛� 遺꾩꽍�썑 諛붾�� 媛� 留듭뿉 ���옣  + �뙆�씪�벐湲�
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
				//留뚯빟 蹂�寃쎌궗�빆�씠 �뾾�뒗寃쎌슦(吏��슦湲곕쭔 �븳 寃쎌슦)
				image = room_image;
			}
			//sql�쟾�넚(updateRoom_image)
			Map<String, String> map = new HashMap<String, String>();
			map.put("room_num", room_num);
			map.put("room_image", image);
			sqlSession.update("updateRoom_image", map);
			//�꽌踰� �뀒�씠釉붿뿉 �벑濡�(Room)
			RoomDTO rdto = room_list.get(room_num);
			rdto.setRoom_image(image);
			room_list.put(room_num, rdto);
		}
	}
	//�뙆�씪硫뷀꽣媛믨낵 �쁽�옱�뙆�씪媛� 遺꾩꽍 諛� ���옣
	private synchronized void imageCheck(MultipartFile mf, String target_image, String upPath, Integer count, Hashtable<Integer, String> change_index) {
		String[] images = target_image.split(",");
		for(int i=0; i<images.length; ++i) {
			String image = images[i];
			//�뙆�씪�씠由꾩씠 �뿬湲� �씠由꾧낵 媛숈�吏� 鍮꾧탳
			boolean check = false;
			String filename = mf.getOriginalFilename();
			if(filename.equals(image)) {
				Enumeration<Integer> change_index_key = change_index.keys();
				while(change_index_key.hasMoreElements()) {
					Integer index = change_index_key.nextElement();
					if(i==index) check = true;
				}
				if(check) continue;
				//留뚯빟 �뙆�씪�씠 �씠誘� �엳�떎硫�  �씠由꾩쓣 �쟻�뼱�몢怨� �떎�쓬�뙆�씪濡�
				if(!new File(upPath, image).exists()) {
					count = count+1;
					//�뾾�뒗 �뙆�씪�씠�씪硫� �떆媛� + count + �솗�옣�옄 ���옣
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
	//占쏙옙占쏙옙 占쏙옙占�
	public List<AccomodationDTO> listAccomodation(String input_place, String start_date, String end_date, String people, int startRow, int endRow){
		HashMap<String, String> map = new HashMap<String, String>();
		String startRowStr = Integer.toString(startRow);
		String endRowStr = Integer.toString(endRow);
		map.put("startRow", startRowStr);
		map.put("endRow", endRowStr);
		map.put("country", input_place);
		map.put("start_date", start_date);
		map.put("end_date", end_date);
		return sqlSession.selectList("listAccomodation", map);
	}
	//占쏙옙占쏙옙 占쏙옙체 占쏙옙占�
	public List<AccomodationDTO> listAccomodation(int startRow, int endRow) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sqlSession.selectList("listAccomodationAll");
	}
	//占쏙옙占쏙옙 占쏙옙占�
	public int insertReservation(ReservationDTO dto) {
		return sqlSession.insert("insertReservation", dto);
	}
	//占쏙옙占쏙옙 占쏙옙占�
	public int deleteReservation(int num) {
		return sqlSession.delete("deleteReservation", num);
	}
	//占쏙옙 占싹놂옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
	public RoomDTO getRoom(int num) {
		return sqlSession.selectOne("getRoom", num);
	}
	//占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
	public AccomodationDTO getAccomodationInfo(int num) {
		return sqlSession.selectOne("getAccomodationInfo", num);
	}
	//占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
	public int getCount() {
		return sqlSession.selectOne("getCount");
	}
}

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
		
		//�씠踰� �벑濡앸룞�븞 �궗�슜�븷 留�, 移댁슫�꽣
		Integer count = 0;
		Hashtable<Integer, String> change_index = new Hashtable<Integer, String>();
		String image = "";
		
		for(MultipartFile mf : accomodatation_files) {
			//�뙆�씪�씠 �씠誘몄� ���엯�씠 �븘�땶寃쎌슦 �떎�쓬�뙆�씪濡�
			if(!mf.getContentType().substring(0, 5).equals("image")) continue;
			//�뙆�씪硫뷀꽣 媛� 遺꾩꽍�썑 諛붾�� 媛� 留듭뿉 ���옣  + �뙆�씪�벐湲�
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
	//占쎌�占쏙옙占쎈퓠 筌띿쉶�뮉 占쎈땿占쎈꺖 揶쏉옙占쎌죬占쎌궎疫뀐옙
	public Hashtable<String, RoomDTO> getRoomList(String num){
		List<RoomDTO> list = sqlSession.selectList("getRoomList", num);
		Hashtable<String, RoomDTO> table = new Hashtable<String, RoomDTO>();
		for(RoomDTO dto : list) {
			table.put(String.valueOf(dto.getNum()), dto);
		}
		return table;
	}
	//占쎈땿占쎈꺖 占쎈뻻占쎄퐬 占쎈씜占쎈쑓占쎌뵠占쎈뱜
	public void updateAccomodation_facility(String accomodation_num, String accomodation_facility) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("accomodation_facility", accomodation_facility);
		sqlSession.update("updateAccomodation_facility", map);
	}
	//占쎈땿占쎈꺖 占쎄땀占쎌뒠 占쎈씜占쎈쑓占쎌뵠占쎈뱜
	public void updateContent(String accomodation_num, String content) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("content", content);
		sqlSession.update("updateContent", map);
	}
	//占쎈땿占쎈꺖 占쎌젟筌�占� 占쎈씜占쎈쑓占쎌뵠占쎈뱜
	public void updatePolicy(String accomodation_num, Map<String, String> map) {
		sqlSession.update("updatePolicy", map);
	}
	//雅뚯눖占쏙옙�뻻占쎄퐬
	public void updateNearby(String accomodation_num, String nearby) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("nearby", nearby);
		sqlSession.update("updateNearby", map);
	}
	//占쎈땿占쎈꺖 占쎌뵠沃섎챷占� 癰귨옙野껓옙
	public void updateImage(MultipartHttpServletRequest mr) {
		HttpSession session = mr.getSession();
		String accomodation_image = mr.getParameter("accomodation_image");
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		//占쎌뵠甕곤옙 占쎈쾻嚥≪빖猷욑옙釉� 占쎄텢占쎌뒠占쎈막 筌랃옙, 燁삳똻�뒲占쎄숲
		Integer count = 0;
		Hashtable<Integer, String> change_index = new Hashtable<Integer, String>();
		
		String upPath = session.getServletContext().getRealPath("resources/img");
		List<MultipartFile> accomodatation_files = mr.getFiles("accomodation_files");
		String image = "";
		if(accomodatation_files.size()!=0) {
			for(MultipartFile mf : accomodatation_files) {
				//占쎈솁占쎌뵬占쎌뵠 占쎌뵠沃섎챷占� 占쏙옙占쎌뿯占쎌뵠 占쎈툡占쎈빒野껋럩�뒭 占쎈뼄占쎌벉占쎈솁占쎌뵬嚥∽옙
				if(!mf.getContentType().substring(0, 5).equals("image")) continue;
				//占쎈솁占쎌뵬筌롫�苑� 揶쏉옙 �겫袁⑷퐤占쎌뜎 獄쏅뗀占쏙옙 揶쏉옙 筌띾벊肉� 占쏙옙占쎌삢  + 占쎈솁占쎌뵬占쎈쾺疫뀐옙
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
			//筌띾슣鍮� 癰귨옙野껋럩沅쀯옙鍮놅옙�뵠 占쎈씨占쎈뮉野껋럩�뒭(筌욑옙占쎌뒭疫꿸퀡彛� 占쎈립 野껋럩�뒭)
			image = accomodation_image;
		}
		//sql占쎌읈占쎈꽊(updateImage)
		Map<String, String> map = new HashMap<String, String>();
		map.put("accomodation_num", accomodation_num);
		map.put("image", image);
		sqlSession.update("updateImage", map);
		//占쎄퐣甕곤옙 占쎈�믭옙�뵠�뇡遺용퓠 占쎈쾻嚥∽옙(Accomodation)
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO adto = table.get(accomodation_num);
		adto.setImage(image);
		table.put(accomodation_num, adto);
		//獄쏉옙 占쎈쾻嚥∽옙 占쎈뻻占쎌삂
		updateRoom_image(mr, count);
	}
	//獄쏉옙 占쎌뵠沃섎챷占� 癰귨옙野껓옙
	public void updateRoom_image(MultipartHttpServletRequest mr, Integer count) {
		HttpSession session = mr.getSession();
		String upPath = session.getServletContext().getRealPath("resources/img");
		Hashtable<String, RoomDTO> room_list = (Hashtable)session.getAttribute("room_list");
		Enumeration<String> key = room_list.keys();
		while(key.hasMoreElements()) {
			String room_num = key.nextElement();
			String room_image = mr.getParameter(room_num + "room_image");
			List<MultipartFile> room_files = mr.getFiles(room_num + "room_files");
			//占쎌뵠甕곤옙 占쎈쾻嚥≪빖猷욑옙釉� 占쎄텢占쎌뒠占쎈막 筌랃옙, 燁삳똻�뒲占쎄숲
			Hashtable<Integer, String> change_index = new Hashtable<Integer, String>();
			count = count+100;
			String image = "";
			if(room_files.size()!=0) {
				for(MultipartFile mf : room_files) {
					//占쎈솁占쎌뵬占쎌뵠 占쎌뵠沃섎챷占� 占쏙옙占쎌뿯占쎌뵠 占쎈툡占쎈빒野껋럩�뒭 占쎈뼄占쎌벉占쎈솁占쎌뵬嚥∽옙
					if(!mf.getContentType().substring(0, 5).equals("image")) continue;
					//占쎈솁占쎌뵬筌롫�苑� 揶쏉옙 �겫袁⑷퐤占쎌뜎 獄쏅뗀占쏙옙 揶쏉옙 筌띾벊肉� 占쏙옙占쎌삢  + 占쎈솁占쎌뵬占쎈쾺疫뀐옙
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
				//筌띾슣鍮� 癰귨옙野껋럩沅쀯옙鍮놅옙�뵠 占쎈씨占쎈뮉野껋럩�뒭(筌욑옙占쎌뒭疫꿸퀡彛� 占쎈립 野껋럩�뒭)
				image = room_image;
			}
			//sql占쎌읈占쎈꽊(updateRoom_image)
			Map<String, String> map = new HashMap<String, String>();
			map.put("room_num", room_num);
			map.put("room_image", image);
			sqlSession.update("updateRoom_image", map);
			//占쎄퐣甕곤옙 占쎈�믭옙�뵠�뇡遺용퓠 占쎈쾻嚥∽옙(Room)
			RoomDTO rdto = room_list.get(room_num);
			rdto.setRoom_image(image);
			room_list.put(room_num, rdto);
		}
	}
	//占쎈솁占쎌뵬筌롫�苑ｅ첎誘⑤궢 占쎌겱占쎌삺占쎈솁占쎌뵬揶쏉옙 �겫袁⑷퐤 獄쏉옙 占쏙옙占쎌삢
	private synchronized void imageCheck(MultipartFile mf, String target_image, String upPath, Integer count, Hashtable<Integer, String> change_index) {
		String[] images = target_image.split(",");
		for(int i=0; i<images.length; ++i) {
			String image = images[i];
			//占쎈솁占쎌뵬占쎌뵠�뵳袁⑹뵠 占쎈연疫뀐옙 占쎌뵠�뵳袁㏓궢 揶쏆늿占쏙쭪占� �뜮袁㏉꺍
			boolean check = false;
			String filename = mf.getOriginalFilename();
			if(filename.equals(image)) {
				Enumeration<Integer> change_index_key = change_index.keys();
				while(change_index_key.hasMoreElements()) {
					Integer index = change_index_key.nextElement();
					if(i==index) check = true;
				}
				if(check) continue;
				//筌띾슣鍮� 占쎈솁占쎌뵬占쎌뵠 占쎌뵠沃섓옙 占쎌뿳占쎈뼄筌롳옙  占쎌뵠�뵳袁⑹뱽 占쎌읅占쎈선占쎈あ�⑨옙 占쎈뼄占쎌벉占쎈솁占쎌뵬嚥∽옙
				if(!new File(upPath, image).exists()) {
					count = count+1;
					//占쎈씨占쎈뮉 占쎈솁占쎌뵬占쎌뵠占쎌뵬筌롳옙 占쎈뻻揶쏉옙 + count + 占쎌넇占쎌삢占쎌쁽 占쏙옙占쎌삢
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
	//숙소 목록
	public List<AccomodationDTO> listAccomodation(String input_place, String start_date, String end_date, int startRow, int endRow){
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
	//예약 등록
	public int insertReservation(ReservationDTO dto) {
		return sqlSession.insert("insertReservation", dto);
	}
	//예약 취소
	public int deleteReservation(int num) {
		return sqlSession.delete("deleteReservation", num);
	}
	//방 하나 정보 가져오기
	public RoomDTO getRoom(int num) {
		return sqlSession.selectOne("getRoom", num);
	}
	//숙소 정보 가져오기
	public AccomodationDTO getAccomodationInfo(int num) {
		return sqlSession.selectOne("getAccomodationInfo", num);
	}
	//숙소 갯수 가져오기
	public int getCount(String input_place, String start_date, String end_date) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("country", input_place);
		map.put("start_date", start_date);
		map.put("end_date", end_date);
		return sqlSession.selectOne("getCount", map);
	}
}

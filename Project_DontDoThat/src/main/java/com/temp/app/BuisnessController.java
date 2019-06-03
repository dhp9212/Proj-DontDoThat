package com.temp.app;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.temp.app.model.AccomodationDTO;
import com.temp.app.model.RoomDTO;
import com.temp.app.service.AccomodationMapper;

@Controller
public class BuisnessController {
	//경로
	String calenderPath = "buisness/calenderMenu/";
	String accomodationPath = "buisness/accomodationMenu/";
	String payPath = "buisness/payMenu/";
	
	@Autowired
	AccomodationMapper accomodationMapper;
	
	//세션 명칭
	HttpSession session;
	
	@RequestMapping(value="buisness_index.do")
	public String index(HttpServletRequest req) {
		session = req.getSession();
		return "buisness/buisness_index";
	}
	@RequestMapping(value="calender.do")
	public String calender() {
		return calenderPath + "calender";
	}
	@RequestMapping(value="open_close.do")
	public String open_close() {
		return calenderPath + "open_close";
	}
	@RequestMapping(value="qty_control.do")
	public String qty_control() {
		return calenderPath + "qty_control";
	}
	@RequestMapping(value="payment.do")
	public String payment() {
		return calenderPath + "payment";
	}
	@RequestMapping(value="pay_control.do")
	public String pay_control() {
		return calenderPath + "pay_control";
	}
	@RequestMapping(value="pay_policy.do")
	public String pay_policy() {
		return calenderPath + "pay_policy";
	}
	@RequestMapping(value="homepage.do")
	public String homepage() {
		return accomodationPath + "homepage";
	}
	@RequestMapping(value="accomodation_facility.do")
	public String accomodation_facility(HttpServletRequest req) {
		session = req.getSession();
		return accomodationPath + "accomodation_facility";
	}
	@RequestMapping(value="nearby.do")
	public String unearby() {
		return accomodationPath + "nearby";
	}
	@RequestMapping(value="general_info.do")
	public String general_info(HttpServletRequest req) {
		String accomodation_num = req.getParameter("accomodation_num");
		session = req.getSession();
		if(accomodation_num!=null) {
			Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
			session.setAttribute("accomodation_num", accomodation_num);
			session.setAttribute("accomodation_dto", table.get(accomodation_num));
			session.setAttribute("room_list", accomodationMapper.getRoomList(accomodation_num));
		}
		return accomodationPath + "general_info";
	}
	@RequestMapping(value="room_content.do")
	public String room_content() {
		return accomodationPath + "room_content";
	}
	@RequestMapping(value="accomodation_content.do")
	public String accomodation_content() {
		return accomodationPath + "accomodation_content";
	}
	@RequestMapping(value="room_facility.do")
	public String room_facility(HttpServletRequest req) {
		String room_num = req.getParameter("room_num");
		Hashtable<String, RoomDTO> table = (Hashtable)session.getAttribute("room_list");
		req.setAttribute("roomDTO", table.get(room_num));
		return accomodationPath + "room_facility";
	}
	@RequestMapping(value="message_setting.do")
	public String message_setting() {
		return accomodationPath + "message_setting";
	}
	@RequestMapping(value="picture.do")
	public String picture() {
		return accomodationPath + "picture";
	}
	@RequestMapping(value="onTheWay.do")
	public String onTheWay() {
		return accomodationPath + "onTheWay";
	}
	@RequestMapping(value="policy.do")
	public String policy() {
		return accomodationPath + "policy";
	}
	@RequestMapping(value="profile.do")
	public String profile() {
		return accomodationPath + "profile";
	}
	@RequestMapping(value="custom_message.do")
	public String custom_message() {
		return payPath + "custom_message";
	}
	@RequestMapping(value="admin_message.do")
	public String admin_message() {
		return payPath + "admin_message";
	}
	@RequestMapping(value="bill.do")
	public String bill() {
		return payPath + "bill";
	}
	@RequestMapping(value="reservation_specification.do")
	public String reservation_specification() {
		return payPath + "reservation_specification";
	}
	@RequestMapping(value="financial_overview.do")
	public String financial_overview() {
		return payPath + "financial_overview";
	}
	@RequestMapping(value="account_info.do")
	public String account_info() {
		return payPath + "account_info";
	}
	@RequestMapping(value="updateRoom.do")
	public String updateRoom(HttpServletRequest req, @ModelAttribute RoomDTO dto) {
		accomodationMapper.updateRoom(dto);
		session = req.getSession();
		Hashtable<String, RoomDTO> table = (Hashtable)session.getAttribute("room_list");
		table.put(String.valueOf(dto.getNum()), dto);
		return "forward:general_info.do";
	}
	@RequestMapping(value="updateAccomodation_facility")
	public String updateAccomodation_facility(HttpServletRequest req) {
		session = req.getSession();
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		String accomodation_facility = req.getParameter("accomodation_facility");
		//데이터베이스 저장
		accomodationMapper.updateAccomodation_facility(accomodation_num, accomodation_facility);
		//변경사항 서버에 저장
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO dto = table.get(accomodation_num);
		dto.setAccomodation_facility(accomodation_facility);
		table.put(accomodation_num, dto);
		
		return "forward:general_info.do";
	}
	@RequestMapping(value="updateContent")
	public String updateContent(HttpServletRequest req) {
		session = req.getSession();
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		String content = req.getParameter("content");
		//데이터베이스 저장
		accomodationMapper.updateContent(accomodation_num, content);
		//변경사항 서버에 저장
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO dto = table.get(accomodation_num);
		dto.setContent(content);
		table.put(accomodation_num, dto);
		
		return "forward:general_info.do";
	}
	@RequestMapping(value="updatePolicy")
	public String updatePolicy(HttpServletRequest req) {
		session = req.getSession();
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		String policy = req.getParameter("policy");
		//데이터베이스 저장
		accomodationMapper.updatePolicy(accomodation_num, policy);
		//변경사항 서버에 저장
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO dto = table.get(accomodation_num);
		dto.setPolicy(policy);
		table.put(accomodation_num, dto);
		
		return "forward:general_info.do";
	}
	@RequestMapping(value="updateNearby")
	public String updateNearby(HttpServletRequest req) {
		session = req.getSession();
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		String nearby = req.getParameter("nearby");
		//데이터베이스 저장
		accomodationMapper.updateNearby(accomodation_num, nearby);
		//변경사항 서버에 저장
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO dto = table.get(accomodation_num);
		dto.setNearby(nearby);
		table.put(accomodation_num, dto);
		
		return "forward:general_info.do";
	}
	@RequestMapping(value="updateImage.do")
	public String updateImage(HttpServletRequest req) {
		//경로지정
		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("resources/img");
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		List<MultipartFile> files = mr.getFiles("files");
		for(MultipartFile mf : files) {
			//서버에 파일쓰기
			File file = new File(upPath, mf.getOriginalFilename());
			try {
				mf.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		Hashtable<String, RoomDTO> room_list = (Hashtable)session.getAttribute("room_list");
		Enumeration<String> key = room_list.keys();
		while(key.hasMoreElements()) {
			//데이터베이스에 저장(Room)
			String room_num = key.nextElement();
			String room_image = req.getParameter(room_num + "room_image");
			accomodationMapper.updateRoom_image(room_num, room_image);
			//변경내용 세션저장(Room)
			RoomDTO dto = room_list.get(room_num);
			dto.setRoom_image(room_image);
			room_list.put(room_num, dto);
		}
		//데이터베이스에 저장(Accomodation)
		String accomodation_image = req.getParameter("accomodation_image");
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		accomodationMapper.updateImage(accomodation_num, accomodation_image);
		//변경사항 세션 저장(Accomodation)
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO dto = table.get(accomodation_num);
		dto.setImage(accomodation_image);
		table.put(accomodation_num, dto);
		return "forward:general_info.do";
	}
	@RequestMapping(value="test.do")
	public String test(HttpServletRequest req) {
		return "room/insertImage_include";
	}
}

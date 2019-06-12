package com.temp.app;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.temp.app.model.AccomodationDTO;
import com.temp.app.model.GradeDTO;
import com.temp.app.model.MessageDTO;
import com.temp.app.model.ReviewGradeDTO;
import com.temp.app.model.RoomDTO;
import com.temp.app.service.AccomodationMapper;
import com.temp.app.service.MessageMapper;
import com.temp.app.service.ReviewMapper;

@Controller
public class BuisnessController {
	String calenderPath = "buisness/calenderMenu/";
	String accomodationPath = "buisness/accomodationMenu/";
	String payPath = "buisness/payMenu/";
	String reviewPath = "buisness/reviewMenu/";
	@Autowired
	AccomodationMapper accomodationMapper;
	
	@Autowired
	MessageMapper adminMessageMapper;
	
	@Autowired
	ReviewMapper reviewMapper;
	
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
	@RequestMapping(value="review_policy.do")
	public String review_policy() {
		return accomodationPath + "review_policy";
	}
	@RequestMapping(value="profile.do")
	public String profile() {
		return accomodationPath + "profile";
	}
	@RequestMapping(value="custom_review.do")
	public String custom_review(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String accommodation = (String)session.getAttribute("accommodation");
		if(accommodation == null) {
			accommodation = "text";
		}
		List<ReviewGradeDTO> reviewlist = reviewMapper.listReview(accommodation);
		int reviewcount = reviewMapper.countReview(accommodation);
		GradeDTO reviewaverage = reviewMapper.averageReview(accommodation);
		req.setAttribute("reviewlist", reviewlist);
		req.setAttribute("reviewcount", reviewcount);
		req.setAttribute("reviewaverage", reviewaverage);
		return reviewPath + "custom_review"; 
	}
	@RequestMapping(value="custom_experience.do")
	public String custom_experience() {
		return reviewPath + "custom_experience";
	}
	@RequestMapping(value="custom_message.do")
	public String custom_message() {
		return payPath + "custom_message";
	}
	@RequestMapping(value="admin_message.do")
	public String admin_message(HttpServletRequest req) {
		//
		LinkedHashMap<String, List<String>> sc = new LinkedHashMap<String, List<String>>();
		List<String> sc_cate = new ArrayList<String>();
		sc_cate.add("요금 & 객실 재고 현황");
		sc_cate.add("프로모션");
		sc_cate.add("예약 관련(취소, 변경, 기타 질문 등)");
		sc_cate.add("기회 요인(매출 관련)");
		sc_cate.add("고객 이용 후기");
		sc_cate.add("재무 관련(결제 및 청구서)");
		sc_cate.add("분석 도구");
		sc_cate.add("숙소 상세 정보");
		sc_cate.add("계정 관련");
		req.setAttribute("sc_cate", sc_cate);
		
		String a[] = new String[] {"객실 재고 추가/변경", "요금 생성/변경", "객실 정책",
				"기타", "요금 & 객실 재고 현황"};
		sc.put("요금 & 객실 재고 현황", admin_message_input (a));
		String b[] = new String[] {"취소", "도착 시간 요청", "변경",
				"결제", "기타"};
		sc.put("예약 관련(취소, 변경, 기타 질문 등)", admin_message_input (b));
		String c[] = new String[] {"청구서 일반 문의", "청구서 정정 관련 문의"};
		sc.put("재무 관련(결제 및 청구서)", admin_message_input (c));
		String d[] = new String[] {"부가세(VAT)", "도시세/추가 요금", "사진", "객실 상세 정보",
				"숙소 정책(주차, 인터넷 등)", "기타"};
		sc.put("숙소 상세 정보", admin_message_input (d));
		req.setAttribute("sc", sc);
		//
		List<MessageDTO> list = adminMessageMapper.listMessage("admin");
		req.setAttribute("messagelist", list);
		return payPath + "admin_message";
	}
	public List<String> admin_message_input(String[] a){
		List<String> list = new ArrayList<String>();
		for(int i=0; i<a.length; i++) {
			list.add(a[i]);
		}
		return list;
	}
	@RequestMapping(value="write_admin_message.do")
	public String write_admin_message(HttpServletRequest req, @ModelAttribute
						MessageDTO dto, BindingResult result) throws Exception {
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		
		MultipartFile mf = mr.getFile("image");
		String upPath = req.getSession().getServletContext().getRealPath("/resources/img");
		String image = mf.getOriginalFilename();
		if(image != "") {
			File file = new File(upPath, mf.getOriginalFilename());
			mf.transferTo(file);
		}
		if(result.hasErrors()) {
			dto.setImage(image);
		}
		String msg = null, url = null;
		try {
			int res = adminMessageMapper.writeMessage(dto);
			if(res>0) {
				msg = "메시지를 전송하였습니다.";
				url = "admin_message.do";
			}else {
				msg = "메시지 전송을 실패하였습니다.";
				url = "admin_message.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "DB서버 오류 발생!! 관리자에게 문의하세요";
			url = "start.app";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	@RequestMapping(value="delete_message.do")
	public String delete_message(HttpServletRequest req) {
		String msg = null, url = null;
		try {
		int res = adminMessageMapper.deleteMessage(Integer.parseInt(req.getParameter("no")));
			if(res > 0) {
				return "redirect:admin_message.do";
			}else {
				msg = "메시지 삭제 실패!";
				url = "admin_message.do";
			}
		}catch (Exception e) {
			e.printStackTrace();
			msg = "DB서버 오류 발생!! 관리자에게 문의하세요";
			url = "start.app";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
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
		//
		accomodationMapper.updateAccomodation_facility(accomodation_num, accomodation_facility);
		//
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
		//
		accomodationMapper.updateContent(accomodation_num, content);
		//
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO dto = table.get(accomodation_num);
		dto.setContent(content);
		table.put(accomodation_num, dto);
		
		return "forward:general_info.do";
	}
	@RequestMapping(value="updatePolicy")
	public String updatePolicy(HttpServletRequest req) {
		session = req.getSession();
		Map<String, String> map = new HashMap<String, String>();
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		String policy = req.getParameter("policy");
		String payment = req.getParameter("payment");
		String checkin_date = req.getParameter("checkin_date");
		String checkout_date = req.getParameter("checkout_date");
		map.put("policy" ,req.getParameter("policy"));
		map.put("payment" ,req.getParameter("payment"));
		map.put("checkin_date" ,req.getParameter("checkin_date"));
		map.put("checkout_date" ,req.getParameter("checkout_date"));
		map.put("accomodation_num", accomodation_num);
		//
		accomodationMapper.updatePolicy(accomodation_num, map);
		//
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO dto = table.get(accomodation_num);
		dto.setPolicy(policy);
		dto.setPayment(payment);
		dto.setCheckin_date(checkin_date);
		dto.setCheckout_date(checkout_date);
		table.put(accomodation_num, dto);
		
		return "forward:general_info.do";
	}
	@RequestMapping(value="updateNearby")
	public String updateNearby(HttpServletRequest req) {
		session = req.getSession();
		String accomodation_num = (String)session.getAttribute("accomodation_num");
		String nearby = req.getParameter("nearby");
		//
		accomodationMapper.updateNearby(accomodation_num, nearby);
		//
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		AccomodationDTO dto = table.get(accomodation_num);
		dto.setNearby(nearby);
		table.put(accomodation_num, dto);
		
		return "forward:general_info.do";
	}
	@RequestMapping(value="updateImage.do")
	public String updateImage(HttpServletRequest req) {
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		//
		accomodationMapper.updateImage(mr);
		
		return "forward:general_info.do";
	}
}

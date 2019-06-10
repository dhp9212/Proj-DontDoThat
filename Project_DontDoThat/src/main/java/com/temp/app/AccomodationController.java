package com.temp.app;

import java.util.Hashtable;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.temp.app.model.AccomodationDTO;
import com.temp.app.model.ReservationDTO;
import com.temp.app.model.RoomDTO;
import com.temp.app.service.AccomodationMapper;

@Controller
public class AccomodationController {
	private static final Logger logger = LoggerFactory.getLogger(AccomodationController.class);
	
	@Autowired
	private AccomodationMapper accomodationMapper;
	
	@RequestMapping(value="/accomodation_list.do")
	public String listAccomodation(HttpServletRequest req) throws Exception {
		String input_place = req.getParameter("input_place").trim();
		String start_date = req.getParameter("start_date").trim();
		String end_date = req.getParameter("end_date").trim();
		String people = req.getParameter("people").trim();
		String pageNum = req.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		}
		int currentPage = Integer.parseInt(pageNum);
		int pageSize = 5;
		int startRow = (currentPage - 1) * pageSize + 1;
		int listCount = accomodationMapper.getCount();
		int endRow = currentPage * pageSize;
		if (endRow > listCount) endRow = listCount;
		System.out.println(listCount);
		List<AccomodationDTO> list = accomodationMapper.listAccomodation(input_place, start_date, end_date, people, startRow, endRow);
		req.setAttribute("listAccomodation", list);
		if (listCount > 0) {
			int pageCount = listCount / pageSize + (listCount % pageSize == 0 ? 0 : 1);
			int pageBlock = 10;
			int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
			int endPage = startPage + pageBlock - 1;
			if (endPage > pageCount) endPage = pageCount;
			req.setAttribute("listCount", listCount);
			req.setAttribute("pageCount", pageCount);
			req.setAttribute("startPage", startPage);
			req.setAttribute("endPage", endPage);
		}
		return "accomodation/list";
	}
	@RequestMapping(value="/search_accomodation_content.do")
	public String contentAccomodation(HttpServletRequest req, @RequestParam int num) throws Exception {
		AccomodationDTO dto = accomodationMapper.getAccomodationInfo(num);
		req.setAttribute("getAccomodationInfo", dto);
		String numStr = Integer.toString(num);
		Hashtable<String, RoomDTO> list = accomodationMapper.getRoomList(numStr);
		req.setAttribute("getRoomList", list);
		return "accomodation/content";
	}
	@RequestMapping(value="/accomodation_reservation.do", method=RequestMethod.GET)
	public String reservationForm(HttpServletRequest req, @RequestParam int num) throws Exception {
		RoomDTO dto = accomodationMapper.getRoom(num);
		req.setAttribute("getRoom", dto);
		System.out.println("can?");
		return "accomodation/reservation";
	}
	@RequestMapping(value="/accomodation_reservation.do", method=RequestMethod.POST)
	protected ModelAndView reservationPro(HttpServletRequest req, @ModelAttribute ReservationDTO dto, BindingResult result) throws Exception {
		if (result.hasErrors()) {
			dto.setNum(0);
		}
		int res = accomodationMapper.insertReservation(dto);
		if (res > 0) {
			System.out.println("예약 성공");
		} else {
			System.out.println("예약 실패");
		}
		return new ModelAndView("redirect:home.do");
	}
}

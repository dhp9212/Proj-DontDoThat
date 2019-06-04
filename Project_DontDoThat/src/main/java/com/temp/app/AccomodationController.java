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
	public String listAccomodation(HttpServletRequest req, @RequestParam(defaultValue="1") int currentPage) throws Exception {
		String input_place = req.getParameter("input_place").trim();
		String start_date = req.getParameter("start_date").trim();
		String end_date = req.getParameter("end_date").trim();
		String people = req.getParameter("people").trim();

		List<AccomodationDTO> list = accomodationMapper.listAccomodation(input_place, start_date, end_date, people);
		req.setAttribute("listAccomodation", list);

		return "accomodation/list";
	}
	@RequestMapping(value="/search_accomodation_content.do")
	public String contentAccomodation(HttpServletRequest req, @RequestParam int num) throws Exception {
		Hashtable<String, AccomodationDTO> table = accomodationMapper.getAccomodation(num);
		req.setAttribute("getAccomodation", table);
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
		System.out.println(req.getAttribute("last_name"));
		
		int res = accomodationMapper.insertReservation(dto);
		
		return new ModelAndView("redirect:accomodation_list.do");
	}

}

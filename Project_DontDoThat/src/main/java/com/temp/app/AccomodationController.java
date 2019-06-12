package com.temp.app;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		String adult = req.getParameter("adult").trim();
		String child = req.getParameter("child").trim();
		String room = req.getParameter("room").trim();
		
		
		
		req.getSession().setAttribute("input_place", input_place);
		if(start_date == null || start_date.equals("")) {
			Calendar cal = Calendar.getInstance();
			int year = cal.get(cal.YEAR);
			int month = (cal.get(cal.MONTH)+1);
			String monthStr;
			if(month < 10) monthStr = "0" + month;
			else monthStr = month + "";
			int day = cal.get(cal.DATE);
			String dayStr;
			if(day < 10) dayStr = "0" + day;
			else dayStr = day + "";
			
			start_date = year + "/" + monthStr + "/" + dayStr;
			
			if(end_date == null || end_date.equals("")) {
				cal.add(Calendar.DATE, 1);
				int nextday = cal.get(cal.DATE);
				String nextdayStr;
				if(day < 10) nextdayStr = "0" + nextday;
				else nextdayStr = nextday + "";
				end_date = year + "/" + monthStr + "/" + nextdayStr;
			}
		}
		req.getSession().setAttribute("start_date", start_date);
		req.getSession().setAttribute("end_date", end_date);
		
        String pageNum = req.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";
        }
        int currentPage = Integer.parseInt(pageNum);
        int pageSize = 10;
        
        int startRow = (currentPage - 1) * pageSize + 1;
        int listCount = accomodationMapper.getCount(input_place, start_date, end_date);
        int endRow = currentPage * pageSize;
        
        if (endRow > listCount) endRow = listCount;
        System.out.println(listCount);
        List<AccomodationDTO> list = accomodationMapper.listAccomodation(input_place, start_date, end_date, startRow, endRow);
        req.setAttribute("listAccomodation", list);
        if (listCount > 0) {
            int pageCount = listCount / pageSize + (listCount % pageSize == 0 ? 0 : 1);
            int pageBlock = 10;
            int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
            int endPage = startPage + pageBlock - 1;
            if (endPage > pageCount) endPage = pageCount;
            req.setAttribute("listCount", listCount);
			req.setAttribute("pageCount", pageCount);
            req.setAttribute("startRow", startRow);
            req.setAttribute("endRow", endRow);
			req.setAttribute("startPage", startPage);
			req.setAttribute("endPage", endPage);
		}
		return "accomodation/list";
	}
	@RequestMapping(value="/search_accomodation_content.do")
	public String contentAccomodation(HttpServletRequest req, @RequestParam int num) throws Exception {
		AccomodationDTO dto = accomodationMapper.getAccomodationInfo(num);
		req.setAttribute("getAccomodationInfo", dto);
		
		String[] imgarr = dto.getImage().split(",");
		List<String> imgList = new ArrayList<String>();
		for(int i = 0; i < imgarr.length; i++) {
			imgList.add(imgarr[i]);
		}
		req.setAttribute("imgList", imgList);
		
		String numStr = Integer.toString(num);
		Hashtable<String, RoomDTO> list = accomodationMapper.getRoomList(numStr);
		System.out.println(list.size());
		req.setAttribute("getRoomList", list);
		return "accomodation/content";
	}
	@RequestMapping(value="/accomodation_reservation.do", method=RequestMethod.GET)
	public String reservationForm(HttpServletRequest req, @RequestParam int num) throws Exception {
		RoomDTO dto = accomodationMapper.getRoom(num);
		req.setAttribute("getRoom", dto);
		
		return "accomodation/reservation";
	}
	@RequestMapping(value="/accomodation_reservation.do", method=RequestMethod.POST)
	protected ModelAndView reservationPro(HttpServletRequest req, @ModelAttribute ReservationDTO dto, BindingResult result) throws Exception {
		if (result.hasErrors()) {
			dto.setNum(0);
		}
		int res = accomodationMapper.insertReservation(dto);
		if (res > 0) {
			System.out.println("���� ����");
		} else {
			System.out.println("���� ����");
		}
		return new ModelAndView("redirect:home.do");
	}
}

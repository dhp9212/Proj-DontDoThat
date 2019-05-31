package com.temp.app;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.temp.app.model.AccomodationDTO;
import com.temp.app.model.RoomDTO;
import com.temp.app.service.AccomodationMapper;
import com.temp.app.service.CategoryMapper;
import com.temp.app.service.StandardInformationMapper;

@Controller
public class RoomController {
	@Autowired
	AccomodationMapper accomodationMapper;
	@Autowired
	private StandardInformationMapper standardInformationMapper;
	@Autowired
	private CategoryMapper categoryMapper;
	
	
	private static final Logger logger = LoggerFactory.getLogger(RoomController.class);
	
	@RequestMapping(value="insertRoom.do")
	public String insertFome() {
		return "room/insert";
	}
	@RequestMapping(value="insertRoom1.do")
	public String insertOneForm(HttpServletRequest req) {
		HttpSession session = req.getSession();
		Hashtable<String, List<String>> categoryRoom = (Hashtable<String, List<String>>) session.getAttribute("categoryRoom");
		
		req.setAttribute("country", standardInformationMapper.selectCountry());
		req.setAttribute("sin" , categoryRoom.get("싱글룸"));
		req.setAttribute("dou" , categoryRoom.get("더블룸"));
		req.setAttribute("dor" , categoryRoom.get("도미토리룸"));
		return "room/insert1";
	}
	@RequestMapping(value="insertRoom2.do")
	public String insertManyForm(HttpServletRequest req) {
		HttpSession session = req.getSession();
		Hashtable<String, List<String>> categoryRoom = (Hashtable<String, List<String>>) session.getAttribute("categoryRoom");
		Hashtable<String, List<String>> facilities = (Hashtable<String, List<String>>) session.getAttribute("facilities");
		
		req.setAttribute("country", standardInformationMapper.selectCountry());
		req.setAttribute("sin" , categoryRoom.get("싱글룸"));
		req.setAttribute("dou" , categoryRoom.get("더블룸"));
		req.setAttribute("dor" , categoryRoom.get("도미토리룸"));
		req.setAttribute("facilities", facilities);
		req.setAttribute("card", categoryMapper.selectCardList());
		return "room/insert2";
	}
	@RequestMapping(value="insertRoomPro.do")
	public String insertOne(HttpServletRequest req, @ModelAttribute AccomodationDTO dto, BindingResult result1, @ModelAttribute RoomDTO dto2, BindingResult result2) {
		if(result1.hasErrors()) {
			dto.setNum(0);
			//headname과 tel은 로그인정보에서 가져옴
			dto.setHeadname("사장");
			dto.setTel("02-123-1234");
			dto.setAddress(req.getParameter("roadname") + req.getParameter("detail"));
			dto.setContent("");
			dto.setCheckin_date("제공자와 직접 연락 후 협의");
			dto.setCheckout_date("제공자와 직접 연락 후 협의");
			dto.setPayment("제공자와 직접 연락 후 협의");
			dto.setAccomodation_facility(req.getParameter("facility"));
			dto.setNearby("");
		}

		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("resources/img");
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		List<MultipartFile> files = mr.getFiles("files");
		String image = "";
		for(MultipartFile mf : files) {
			//서버에 파일쓰기
			String filename = mf.getOriginalFilename();
			if(image.equals("")) image = filename;
			else image += "," + filename;
			File file = new File(upPath, mf.getOriginalFilename());
			try {
				mf.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		dto.setImage(image);
		//숙소등록
		int num = accomodationMapper.insertAccomodation(dto);
		//룸 등록
		dto2.setAccomodation_num(num);
		dto2.setRoomname(dto.getAccomodation_name());
		dto2.setRoomclass(" ");
		dto2.setQty(1);
		dto2.setRoom_facility(req.getParameter("facility"));
		accomodationMapper.insertRoom(dto2);
		return "forward:/";
	}
	
	@RequestMapping(value="insertRoomPro2.do")
	public String insertMany(HttpServletRequest req, @ModelAttribute AccomodationDTO aDTO, BindingResult result) {
		HttpSession session = req.getSession();
		String upPath = session.getServletContext().getRealPath("resources/img");
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		List<MultipartFile> files = mr.getFiles("files");
		String image = "";
		for(MultipartFile mf : files) {
			//서버에 파일쓰기
			String filename = mf.getOriginalFilename();
			if(image.equals("")) image = filename;
			else image += "," + filename;
			File file = new File(upPath, mf.getOriginalFilename());
			try {
				mf.transferTo(file);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		//숙소 먼저 등록
		if(result.hasErrors()) {
			aDTO.setImage(image);
			aDTO.setAddress(req.getParameter("roadname") + req.getParameter("detail"));
			aDTO.setContent("");
			aDTO.setNearby("");
		}
		int num = accomodationMapper.insertAccomodation(aDTO);
		//룸 등록
		ArrayList<RoomDTO> list = new ArrayList<RoomDTO>();
		String name = req.getParameter("roominit");
		String[] splitName = name.split(",");
		for(int i=0; i<splitName.length/6; ++i) {
			RoomDTO dto = new RoomDTO();
			dto.setAccomodation_num(num);
			dto.setRoomname(splitName[0 + 6*i]);
			dto.setRoomclass(splitName[1 + 6*i]);
			dto.setQty(Integer.parseInt(splitName[2 + 6*i]));
			dto.setPeople(Integer.parseInt(splitName[3 + 6*i]));
			dto.setPrice(Integer.parseInt(splitName[4 + 6*i]));
			dto.setRoom_facility(splitName[5 + 6*i]);
			list.add(dto);
		}
		accomodationMapper.insertRoom(list);
		return "forward:/";
	}
}

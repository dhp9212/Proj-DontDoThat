package com.temp.app;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.temp.app.model.AccountDTO;
import com.temp.app.model.AnswerDTO;
import com.temp.app.model.CategoryAccomodationDTO;
import com.temp.app.model.CityDTO;
import com.temp.app.model.CountryDTO;
import com.temp.app.model.CstmDTO;
import com.temp.app.model.CurrencyDTO;
import com.temp.app.model.FacilityDTO;
import com.temp.app.model.LanguageDTO;
import com.temp.app.model.QA_AnswerDTO;
import com.temp.app.model.QA_SubCateDTO;
import com.temp.app.model.ReservationDTO;
import com.temp.app.model.RoomInfoDTO;
import com.temp.app.service.AccomodationMapper;
import com.temp.app.service.CategoryMapper;
import com.temp.app.service.CustomServiceMapper;
import com.temp.app.service.StandardInformationMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	@Autowired
	private CategoryMapper categoryMapper;
	@Autowired
	private StandardInformationMapper standardInformationMapper;
	@Autowired
	private AccomodationMapper accomodationMapper;
	@Autowired
	private CustomServiceMapper customeServiceMapper; 
	@Autowired
	private JavaMailSender mailSender;
	// session values
	private static Hashtable<String, List<String>> categoryRoom = new Hashtable<String, List<String>>();
	private static Hashtable<String, List<String>> facilities = new Hashtable<String, List<String>>();
	private static List<String> cardList = new ArrayList<String>();
	
	
	/**
	 * move to main homepage with values 
	 * @return page with values
	 */
	@RequestMapping(value="home.do")
	public void home_command(HttpServletRequest req) {
		main_home(req);
	}
	@RequestMapping(value = "/")
	public ModelAndView main_home(HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		if(session.getAttribute("userSession")!=null) {
			if(session.getAttribute("accomodation_list")!=null) {
				session.setAttribute("accomodation_list", accomodationMapper.getAccomodation(((AccountDTO)(session.getAttribute("userSession"))).getNum()));
			}
		}
		List<CategoryAccomodationDTO> categoryAccomodationList = categoryMapper.selectCategodyAccomodation();
		System.out.println(categoryAccomodationList.size());
		List<CountryDTO> countryList = standardInformationMapper.selectCountry();
		List<CityDTO> cityList = standardInformationMapper.selectCity();
		List<CityDTO> cityListShuffled = cityList;
		
		List<CurrencyDTO> currencyList = standardInformationMapper.selectCurrency();
		List<LanguageDTO> languageList = standardInformationMapper.selectLanguage();
		Collections.shuffle(cityListShuffled);
		
		setCategoryRoom();
		setFacilities();
		setCardList();
		
		session.setAttribute("categoryRoom", categoryRoom);
		session.setAttribute("facilities", facilities);
		session.setAttribute("cardList", cardList);
		session.setAttribute("cityList", cityList);
		session.setAttribute("cityListShuffled", cityListShuffled);
		session.setAttribute("countryList", countryList);
		session.setAttribute("currencyList", currencyList);
		session.setAttribute("languageList", languageList);
		session.setAttribute("categoryAccomodationList", categoryAccomodationList);
		
		ModelAndView mav = new ModelAndView();
		//mav.addObject("categoryAccomodationList", categoryAccomodationList);
		//mav.addObject("countryList", countryList);
		//mav.addObject("cityList", cityList);
		//mav.addObject("currencyList", currencyList);
		//mav.addObject("languageList", languageList);
		
		mav.setViewName("home");
		
		return mav;
	}
	
	@RequestMapping(value="/search.do")
	public ModelAndView main_search(HttpServletRequest req) {
		
		String place = req.getParameter("input_place");
		String start_date = req.getParameter("start_date");
		String end_date = req.getParameter("end_date");
		
		System.out.println(place);
		System.out.println(start_date);
		System.out.println(start_date);
		
		req.setAttribute("place", place);
		req.setAttribute("start_date", start_date);
		req.setAttribute("end_date", end_date);
		
		return new ModelAndView("search/search");
	}
	
	@RequestMapping(value = "/customerService.do")
	public String main_customService(HttpServletRequest req) throws Exception{
		List<String> maincate = customeServiceMapper.getMainCategory();
		req.setAttribute("maincate", maincate);
		
		List<QA_SubCateDTO> list = customeServiceMapper.getAllSubCate();
		
		Hashtable<String, List<AnswerDTO>> lhm = new Hashtable<String, List<AnswerDTO>>();
		List<AnswerDTO> d = new ArrayList<AnswerDTO>();
		String str = null;
		for(QA_SubCateDTO mdto : list) {
			QA_AnswerDTO dto;
			if(str == null) {
				str = mdto.getMaincate();
			}
			try {
				dto = customeServiceMapper.getAnswer(Integer.parseInt(mdto.getNo()));
			}catch(Exception e) {dto = null;}
			
			if(dto != null) {
				AnswerDTO adto = new AnswerDTO();
				adto.setNo(dto.getNo());
				adto.setMaincate(dto.getMaincate());
				adto.setSubcate(mdto.getSubcate());
				adto.setAnswer(dto.getAnswer());
				
				if(str.equals(mdto.getMaincate())) {
					d.add(adto);
				}else if(!str.equals(mdto.getMaincate())) {
					lhm.put(str, d);
					str = mdto.getMaincate();
					d = new ArrayList<AnswerDTO>();
					d.add(adto);
				}
			}
		}
		lhm.put(str, d);
	    req.setAttribute("lhm", lhm);
	    
	    HttpSession session = req.getSession();
	    AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
	    int num = dto.getNum();    
        List<ReservationDTO> listReservation = accomodationMapper.listReservation(num);
        req.setAttribute("listReservation", listReservation);
   
		return "custom/cstm";
	}
	@RequestMapping(value="/write_customer_message.do")
	public String write_customer_message(HttpServletRequest req) {
		String data = req.getParameter("reservation");
		String[] sp = data.split("%");
		int reservation = Integer.parseInt(sp[0]);
		int accomodation_num = Integer.parseInt(sp[1]);
		int account_num = accomodationMapper.getAccount_num(accomodation_num);
		String accomodation_name = sp[2];
		String name = req.getParameter("name");
		String tel = req.getParameter("tel");
		String email = req.getParameter("email");
		String content = req.getParameter("content");
		
		CstmDTO f = new CstmDTO();
		f.setReservation(reservation);
		f.setAccount_num(account_num);
		f.setAccomodation_name(accomodation_name);
		f.setName(name);
		f.setTel(tel);
		f.setEmail(email);
		f.setContent(content);
		
		customeServiceMapper.writeCMessage(f);
		req.setAttribute("msg", "성공적으로 전송하였습니다.");
		req.setAttribute("url", "customerService.do");
		return "message";
	}
	
	@RequestMapping(value="/write_customerService.do")
	public String write_customerService(HttpServletRequest req){
		String setfrom = req.getParameter("email");         
	    String tomail  = "Gnikcah6@gmail.com";   // 받는 사람 이메일
	    String title = setfrom;	   
	    String num = req.getParameter("num");
	    String tel = req.getParameter("tel");
	    String name = req.getParameter("name");
	    String content = null;
	    if(num == "" && tel == "") {
	        content = "(이름: "+name+") "+req.getParameter("content");    // 내용
	    }else if(num == "" && tel != "") {
	    	content =  "(이름: "+name+", 전화번호: "+tel+") "+req.getParameter("content"); 
	    }else if(num != "" && tel == "") {
	    	content =  "(이름: "+name+", 예약번호: "+num+") "+req.getParameter("content"); 
	    }else {
	    	content =  "(이름: "+name+", 예약번호: "+num+", 전화번호: "+tel+") "+req.getParameter("content"); 
	    }
	    
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(tomail);     // 받는사람 이메일
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	      messageHelper.setText(content);  // 메일 내용
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	    req.setAttribute("msg", "성공적으로 전송하였습니다.");
		req.setAttribute("url", "customerService.do");
		return "message";
	}
	
	@RequestMapping(value="/accomodation_category_search.do")
	public ModelAndView accomodation_category_search(HttpServletRequest req) {
		String key = req.getParameter("key");
		CategoryAccomodationDTO categoryDto = categoryMapper.getCategoryAccomodation(Integer.parseInt(key));
		req.setAttribute("categoryDto", categoryDto);
		
		return new ModelAndView("categorySearch");
	}
	
	
	
	
	
	public void setCardList() {
		if(cardList.size() == 0) {
			cardList = categoryMapper.selectCardList();
		}
	}

	public void setCategoryRoom(){
		if(categoryRoom.size()==0) {
			List<RoomInfoDTO> list = categoryMapper.selectCategoryRoom();
			List<String> list2 = new ArrayList<String>();
			String room_name = null;
			for(RoomInfoDTO dto : list) {
				if(dto.getRoom_class()!=room_name) {
					if(room_name==null) {
						room_name = dto.getRoom_class();
					}else if(!dto.getRoom_class().equals(room_name)){
						categoryRoom.put(room_name, list2);
						room_name = dto.getRoom_class();
						list2 = new ArrayList<String>();
					}
				}
				list2.add(dto.getRoom_name());
			}
			categoryRoom.put(room_name, list2);
		}
	}
	
	public void setFacilities(){
		if(facilities.size()==0) {
			List<FacilityDTO> list = categoryMapper.selectFacility();
			List<String> facilityList = new ArrayList<String>();
			String facility_name = null;
			for(FacilityDTO facilityDTO : list) {
				if(facilityDTO.getFacility_class()!=facility_name) {
					if(facility_name==null) {
						facility_name = facilityDTO.getFacility_class();
					}else if(!facilityDTO.getFacility_class().equals(facility_name)){
						facilities.put(facility_name, facilityList);
						facility_name = facilityDTO.getFacility_class();
						facilityList = new ArrayList<String>();
					}
				}
				facilityList.add(facilityDTO.getFacility_name());
			}
			facilities.put(facility_name, facilityList);
		}

	}
	
}

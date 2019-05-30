package com.temp.app;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.temp.app.model.AccountDTO;
import com.temp.app.model.CategoryAccomodationDTO;
import com.temp.app.model.CityDTO;
import com.temp.app.model.CountryDTO;
import com.temp.app.model.CurrencyDTO;
import com.temp.app.model.FacilityDTO;
import com.temp.app.model.LanguageDTO;
import com.temp.app.model.RoomInfoDTO;
import com.temp.app.service.AccomodationMapper;
import com.temp.app.service.CategoryMapper;
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
	
	
	// session values
	private static Hashtable<String, List<String>> categoryRoom = new Hashtable<String, List<String>>();
	private static Hashtable<String, List<String>> facilities = new Hashtable<String, List<String>>();
	private static List<String> cardList = new ArrayList<String>();
	
	
	/**
	 * move to main homepage with values 
	 * @return page with values
	 */
	@RequestMapping(value = "/")
	public ModelAndView main_home(HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		List<CategoryAccomodationDTO> categoryAccomodationList = categoryMapper.selectCategodyAccomodation();
		List<CountryDTO> countryList = standardInformationMapper.selectCountry();
		List<CityDTO> cityList = standardInformationMapper.selectCity();
		List<CurrencyDTO> currencyList = standardInformationMapper.selectCurrency();
		List<LanguageDTO> languageList = standardInformationMapper.selectLanguage();
		
		setCategoryRoom();
		setFacilities();
		setCardList();
		
		session.setAttribute("categoryRoom", categoryRoom);
		session.setAttribute("facilities", facilities);
		session.setAttribute("cardList", cardList);
		session.setAttribute("countryList", countryList);
		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("categoryAccomodationList", categoryAccomodationList);
		mav.addObject("countryList", countryList);
		mav.addObject("cityList", cityList);
		mav.addObject("currencyList", currencyList);
		mav.addObject("languageList", languageList);
		
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
	public String main_customService() throws Exception{
		return "custom/cstm";
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

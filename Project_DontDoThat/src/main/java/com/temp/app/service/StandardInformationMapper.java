package com.temp.app.service;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.app.model.AccomodationDTO;
import com.temp.app.model.AccountDTO;
import com.temp.app.model.CategoryAccomodationDTO;
import com.temp.app.model.CityDTO;
import com.temp.app.model.CountryDTO;
import com.temp.app.model.CurrencyDTO;
import com.temp.app.model.FacilityDTO;
import com.temp.app.model.LanguageDTO;
import com.temp.app.model.RoomInfoDTO;

@Service
public class StandardInformationMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<CountryDTO> selectCountry(){
		return sqlSession.selectList("selectCountry");
	}
	
	public List<CityDTO> selectCity(){
		return sqlSession.selectList("selectCity");
	}
	
	public List<CurrencyDTO> selectCurrency(){
		return sqlSession.selectList("selectCurrency");
	}
	
	public List<LanguageDTO> selectLanguage(){
		return sqlSession.selectList("selectLanguage");
	}
	public void sysout(HttpServletRequest req) {
		List<CategoryAccomodationDTO> categoryAccomodation = sqlSession.selectList("selectCategoryAccomodation");
		List<CityDTO> city = sqlSession.selectList("selectCity");
		List<CountryDTO> country = sqlSession.selectList("selectCountry");
		List<FacilityDTO> facility = sqlSession.selectList("selectFacility");
		List<String> cardList = sqlSession.selectList("selectCardList");
		
		AccountDTO aDTO = (AccountDTO)req.getSession().getAttribute("userSession");
		for(int k=0; k<5; ++k) {
			Hashtable<Integer, String> card_save = new Hashtable<Integer, String>(); 
			for(int i=0; i<5; ++i) {
				int random = (int)(Math.random()*cardList.size());
				card_save.put(random, cardList.get(random));
			}
			Enumeration<Integer> enu = card_save.keys();
			String card = "";
			String comma = "";
			while(enu.hasMoreElements()) {
				card += comma + card_save.get(enu.nextElement());
				comma = ",";
			}
			String policy = "";
			String[] str = new String[] {"no", "pay", "free"};
			for(int i=0; i<3; ++i) {
				switch(i) {
				case 0 :
					int[] time = new int[] {0,1,2,3,7,14};
					String[] a = new String[] {"all", "one"};
					policy += "cancel," + time[(int)(Math.random()*6)] + "," + str[(int)(Math.random()*2)] + ",";
					break;
				case 1 : 
					int random = (int)(Math.random()*3);
					int pay = 0;
					if(random==2) pay = (int)(Math.random()*98)+1;
					policy += "children," + str[random] + "," + pay + ",";
					break;
				case 2 : 
					int random2 = (int)(Math.random()*3);
					int pay2 = 0;
					if(random2==2) pay = (int)(Math.random()*98)+1;
					policy += "pet," + str[random2] + "," + pay2;
					break;
				}
			}
			for(int i=0; i<categoryAccomodation.size(); ++i) {
				CountryDTO cDTO = country.get((int)(Math.random()*country.size()));
				CityDTO cDTO2 = city.get((int)(Math.random()*city.size()));
				FacilityDTO fDTO = facility.get((int)(Math.random()*facility.size()));
				CategoryAccomodationDTO dto = categoryAccomodation.get(i);
				System.out.println("insert into accomodation values(accomodation_seq.nextval, '"+dto.getName()+"','homepage"+i+".com', '사장이름"+i+"', '123-123"+i+"', '숙소이름"+i+"', '"+cDTO.getName()+"','"+cDTO2.getCity()+"','주소"+i+"', '우편번호"+i+"', '"+fDTO.getFacility_name()+"', 'america1 ("+(int)(Math.random()*78)+").jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg', '내용"+i+"', '"+policy+"', '00:00 ~ 24:00', '00:00 ~ 24:00', '"+card+"', "+aDTO.getNum()+", '');");
			}
		}
	}
	public void roomSysout(HttpServletRequest req) {
		List<AccomodationDTO> accomodation = sqlSession.selectList("getAccomodationList");
		List<CategoryAccomodationDTO> categoryAccomodation = sqlSession.selectList("selectCategoryAccomodation");
		List<RoomInfoDTO> categoryRoom = sqlSession.selectList("selectRoomCategory");
		List<FacilityDTO> roomFacility = sqlSession.selectList("selectFacility");
		int[] index = new int[] {0,2,3,4,5,8,11,14,20};
		System.out.println(accomodation.size()+"-----------------------------------------------------------------------------------------");
		for(int k=0; k<accomodation.size()/3; ++k) {
			AccomodationDTO dto = accomodation.get(k);
			boolean check = false;
			String cate = dto.getCategory_accomodation();
			Hashtable<Integer, String> facility_save = new Hashtable<Integer, String>(); 
			for(int i=0; i<index.length; ++i) {
				int random = (int)(Math.random()*roomFacility.size());
				facility_save.put(random, roomFacility.get(random).getFacility_name());
				CategoryAccomodationDTO cateDTO = categoryAccomodation.get(index[i]);
				if(cate.equals(cateDTO.getName())) check = true;
			}
			Enumeration<Integer> enu = facility_save.keys();
			String facility = "";
			String comma = "";
			while(enu.hasMoreElements()) {
				facility += comma + facility_save.get(enu.nextElement());
				comma = ",";
			}
			if(check) {
				System.out.println("insert into room values(room_seq.nextval, "+dto.getNum()+", '"+dto.getAccomodation_name()+"','"+dto.getCategory_accomodation()+"',1,"+((int)(Math.random()*6)+1)+","+((int)(Math.random()*100)+6)*10000+",'" + facility + "','image"+(int)(Math.random()*761)+",image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg');");
			}else {
				for(int i=0; i<3; ++i) {
					RoomInfoDTO room_cate = categoryRoom.get((int)(Math.random()*categoryRoom.size()));
					System.out.println("insert into room values(room_seq.nextval, "+dto.getNum()+", '"+dto.getAccomodation_name()+i+"','"+room_cate.getRoom_name()+"',"+ ((int)(Math.random()*20)+1) +","+((int)(Math.random()*6)+1)+","+((int)(Math.random()*100)+6)*10000+",'" + facility + "','image"+(int)(Math.random()*761)+",image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg,image"+(int)(Math.random()*761)+".jpg');");
				}
			}
		}
	}
}

package com.temp.app.service;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.app.model.AccomodationDTO;
import com.temp.app.model.AccountDTO;
import com.temp.app.model.ReservationDTO;
import com.temp.app.model.RoomDTO;

@Service
public class ReservationMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public void getBuisness_reservation(HttpServletRequest req) {
		HttpSession session = req.getSession();
		List<ReservationDTO> reservation = sqlSession.selectList("getReservation_list");
		List<ReservationDTO> myReservation = new ArrayList<ReservationDTO>();
		List<AccountDTO> account = sqlSession.selectList("memberList");
		List<RoomDTO> room_list = sqlSession.selectList("get_roomAll");
		List<RoomDTO> myRoom_list = new ArrayList<RoomDTO>();
		Hashtable<Integer, AccountDTO> myAccount_list = new Hashtable<Integer, AccountDTO>();
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		Enumeration<String> enu = table.keys();
		while(enu.hasMoreElements()) {
			AccomodationDTO accomodationDTO = table.get(enu.nextElement());
			for(ReservationDTO reservationDTO : reservation) {
				if(reservationDTO.getAccomodation_num()==accomodationDTO.getNum()) {
					myReservation.add(reservationDTO);
					for(AccountDTO accountDTO : account) {
						if(accountDTO.getNum()==reservationDTO.getAccount_num()) {
							myAccount_list.put(accountDTO.getNum(), accountDTO);
							break;
						}
					}
				}
			}
			for(RoomDTO roomDTO : room_list) {
				if(roomDTO.getAccomodation_num()==accomodationDTO.getNum()) myRoom_list.add(roomDTO);
			}
		}
		session.setAttribute("buisness_reservation", myReservation);
		session.setAttribute("buisness_room_list", myRoom_list);
		session.setAttribute("buisness_account", myAccount_list);
	}
}

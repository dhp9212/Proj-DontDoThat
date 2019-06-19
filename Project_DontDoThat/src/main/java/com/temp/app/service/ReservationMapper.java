package com.temp.app.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.LinkedHashMap;
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
	
	public void getBuisness_reservation(HttpServletRequest req, String mode) {
		HttpSession session = req.getSession();
		List<ReservationDTO> reservation = sqlSession.selectList("getReservation_" + mode + "_list");
		List<ReservationDTO> myReservation = new ArrayList<ReservationDTO>();
		List<AccountDTO> account = sqlSession.selectList("memberList");
		Hashtable<Integer, AccountDTO> myAccount_list = new Hashtable<Integer, AccountDTO>();
		Hashtable<String, AccomodationDTO> table = (Hashtable)session.getAttribute("accomodation_list");
		List<RoomDTO> room_list = sqlSession.selectList("get_roomAll");
		List<RoomDTO> myRoom_list = new ArrayList<RoomDTO>();
		Enumeration<String> enu = table.keys();
		while(enu.hasMoreElements()) {
			AccomodationDTO accomodationDTO = table.get(enu.nextElement());
			for(ReservationDTO reservationDTO : reservation) {
				if(reservationDTO.getAccomodation_num()==accomodationDTO.getNum()) {
					for(AccountDTO accountDTO : account) {
						if(accountDTO.getNum()==reservationDTO.getAccount_num()) {
							myAccount_list.put(accountDTO.getNum(), accountDTO);
							break;
						}
					}
					for(RoomDTO roomDTO : room_list) {
						if(roomDTO.getNum()==reservationDTO.getRoom_num()) {
							myRoom_list.add(roomDTO);
							break;
						}
					}
					myReservation.add(reservationDTO);
					break;
				}
			}
		}
		Collections.sort(myReservation);
		if(mode.equals("b")) Collections.reverse(myReservation);
		req.setAttribute("buisness_"+mode+"_reservation", myReservation);
		req.setAttribute("buisness_"+mode+"_account", myAccount_list);
		req.setAttribute("buisness_"+mode+"_room_list", myRoom_list);
	}

	public void getBuisness_bill(HttpServletRequest req) {
		List<ReservationDTO> reservation = sqlSession.selectList("getReservation_b_list");
		Hashtable<String, List<ReservationDTO>> myReservation = new Hashtable<String, List<ReservationDTO>>();
		
		List<AccountDTO> account = sqlSession.selectList("memberList");
		Hashtable<Integer, AccountDTO> myAccount_list = new Hashtable<Integer, AccountDTO>();
		
		List<RoomDTO> room_list = sqlSession.selectList("get_roomAll");
		List<RoomDTO> myRoom_list = new ArrayList<RoomDTO>();
		
		List<ReservationDTO> reservationInit = new ArrayList<ReservationDTO>();
		
		Hashtable<String, AccomodationDTO> table = (Hashtable)req.getSession().getAttribute("accomodation_list");
		Enumeration<String> enu = table.keys();
		while(enu.hasMoreElements()) {
			AccomodationDTO accomodationDTO = table.get(enu.nextElement());
			String month = "";
			for(ReservationDTO reservationDTO : reservation) {
				String[] split = reservationDTO.getCheckOut_date().split("/");
				if(!month.equals(split[0] + "/" + split[1])) {
					if(!month.equals("")) {
						Collections.sort(reservationInit);
						Collections.reverse(reservationInit);
						myReservation.put(month, reservationInit);
					}
				}
				month = split[0] + "/" + split[1];
				if(reservationDTO.getAccomodation_num()==accomodationDTO.getNum()) {
					for(AccountDTO accountDTO : account) {
						if(accountDTO.getNum()==reservationDTO.getAccount_num()) {
							myAccount_list.put(accountDTO.getNum(), accountDTO);
							break;
						}
					}
					for(RoomDTO roomDTO : room_list) {
						if(roomDTO.getNum()==reservationDTO.getRoom_num()) {
							myRoom_list.add(roomDTO);
							break;
						}
					}
					reservationInit.add(reservationDTO);
					break;
				}
			}
			myReservation.put(month, reservationInit);
		}
		List<String> key_list = new ArrayList<String>();
		LinkedHashMap<String, List<ReservationDTO>> sortedReservation = new LinkedHashMap<String, List<ReservationDTO>>();
		Enumeration<String> keys = myReservation.keys();
		while(keys.hasMoreElements()) {
			key_list.add(keys.nextElement());
		}
		Collections.sort(key_list);
		Collections.reverse(key_list);
		for(String days : key_list) {
			sortedReservation.put(days, myReservation.get(days));
		}
		
		req.setAttribute("buisness_bill", sortedReservation);
		req.setAttribute("buisness_b_account", myAccount_list);
		req.setAttribute("buisness_b_room_list", myRoom_list);
	}
	 public int updateReservation(int num) {
			return sqlSession.update("updateReservation", num);
		}
}

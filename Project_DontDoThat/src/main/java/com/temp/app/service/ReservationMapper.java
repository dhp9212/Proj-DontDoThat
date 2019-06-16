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
		req.setAttribute("buisness_"+mode+"_reservation", myReservation);
		req.setAttribute("buisness_"+mode+"_account", myAccount_list);
		req.setAttribute("buisness_"+mode+"_room_list", myRoom_list);
	}

	public void getBuisness_bill(HttpServletRequest req) {
		List<ReservationDTO> reservation = sqlSession.selectList("getReservation_b_list");
		Hashtable<String, List<ReservationDTO>> myReservation = new Hashtable<String, List<ReservationDTO>>();
		List<AccountDTO> account = sqlSession.selectList("memberList");
		Hashtable<Integer, AccountDTO> myAccount_list = new Hashtable<Integer, AccountDTO>();
		Hashtable<String, AccomodationDTO> table = (Hashtable)req.getSession().getAttribute("accomodation_list");
		List<RoomDTO> room_list = sqlSession.selectList("get_roomAll");
		List<RoomDTO> myRoom_list = new ArrayList<RoomDTO>();
		
		List<ReservationDTO> reservationInit = new ArrayList<ReservationDTO>();
		Enumeration<String> enu = table.keys();
		while(enu.hasMoreElements()) {
			AccomodationDTO accomodationDTO = table.get(enu.nextElement());
			String month = "";
			for(ReservationDTO reservationDTO : reservation) {
				String[] split = reservationDTO.getCheckOut_date().split("/");
				if(!month.equals(split[0] + "/" + split[1])) {
					if(!month.equals("")) {
						myReservation.put(month, reservationInit);
					}
				}
				month = split[0] + "/" + split[1];
				if(reservationDTO.getAccomodation_num()==accomodationDTO.getNum()) {
					reservationInit.add(reservationDTO);
					for(AccountDTO accountDTO : account) {
						if(accountDTO.getNum()==reservationDTO.getAccount_num()) {
							myAccount_list.put(accountDTO.getNum(), accountDTO);
							break;
						}
					}
				}
			}
			myReservation.put(month, reservationInit);
			for(RoomDTO roomDTO : room_list) {
				if(roomDTO.getAccomodation_num()==accomodationDTO.getNum()) myRoom_list.add(roomDTO);
			}
		}
		req.setAttribute("buisness_bill", myReservation);
		req.setAttribute("buisness_b_account", myAccount_list);
		req.setAttribute("buisness_b_room_list", myRoom_list);
	}
}

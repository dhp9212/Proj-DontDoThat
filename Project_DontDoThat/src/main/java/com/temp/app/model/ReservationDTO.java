package com.temp.app.model;

public class ReservationDTO {
	private int num;
	private int member_num;
	private int room_num;
	private String last_name;
	private String first_name;
	private String email;
	private String country;
	private String tel;
	private String guest_name;
	private String checkIn_date;
	private String checkOut_date;
	private String rooms;
	private String adults;
	private String children;
	private String payment;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public int getRoom_num() {
		return room_num;
	}
	public void setRoom_num(int room_num) {
		this.room_num = room_num;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getGuest_name() {
		return guest_name;
	}
	public void setGuest_name(String guest_name) {
		this.guest_name = guest_name;
	}
	public String getCheckIn_date() {
		return checkIn_date;
	}
	public void setCheckIn_date(String checkIn_date) {
		this.checkIn_date = checkIn_date;
	}
	public String getCheckOut_date() {
		return checkOut_date;
	}
	public void setCheckOut_date(String checkOut_date) {
		this.checkOut_date = checkOut_date;
	}
	public String getRooms() {
		return rooms;
	}
	public void setRooms(String rooms) {
		this.rooms = rooms;
	}
	public String getAdults() {
		return adults;
	}
	public void setAdults(String adults) {
		this.adults = adults;
	}
	public String getChildren() {
		return children;
	}
	public void setChildren(String children) {
		this.children = children;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
}

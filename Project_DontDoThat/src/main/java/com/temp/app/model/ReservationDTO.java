package com.temp.app.model;

public class ReservationDTO implements Comparable<ReservationDTO>{
	private int num;
	private int account_num;
	private int accomodation_num;
	private int room_num;
	private String last_name;
	private String first_name;
	private String email;
	private String country;
	private String tel;
	private String guest_name;
	private String checkIn_date;
	private String checkOut_date;
	private int rooms;
	private int adults;
	private int children;
	private String payment;
	
	private int check_review;
	
	// additional information
	private String category_accomodation;
	private String accomodation_name;
	private String accomodation_country;
	private String city;
	private String content;
	private String headname;
	private String address;
	private String roomname;
	private String roomclass;
	
	public String getCategory_accomodation() {
		return category_accomodation;
	}
	public void setCategory_accomodation(String category_accomodation) {
		this.category_accomodation = category_accomodation;
	}
	public String getAccomodation_country() {
		return accomodation_country;
	}
	public void setAccomodation_country(String accomodation_country) {
		this.accomodation_country = accomodation_country;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getHeadname() {
		return headname;
	}
	public void setHeadname(String headname) {
		this.headname = headname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRoomname() {
		return roomname;
	}
	public void setRoomname(String roomname) {
		this.roomname = roomname;
	}
	public String getRoomclass() {
		return roomclass;
	}
	public void setRoomclass(String roomclass) {
		this.roomclass = roomclass;
	}
	public int getCheck_review() {
		return check_review;
	}
	public void setCheck_review(int check_review) {
		this.check_review = check_review;
	}
	public String getAccomodation_name() {
		return accomodation_name;
	}
	public void setAccomodation_name(String accomodation_name) {
		this.accomodation_name = accomodation_name;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getAccount_num() {
		return account_num;
	}
	public void setAccount_num(int account_num) {
		this.account_num = account_num;
	}
	public int getAccomodation_num() {
		return accomodation_num;
	}
	public void setAccomodation_num(int accomodation_num) {
		this.accomodation_num = accomodation_num;
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
	public int getRooms() {
		return rooms;
	}
	public void setRooms(int rooms) {
		this.rooms = rooms;
	}
	public int getAdults() {
		return adults;
	}
	public void setAdults(int adults) {
		this.adults = adults;
	}
	public int getChildren() {
		return children;
	}
	public void setChildren(int children) {
		this.children = children;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	@Override
	public int compareTo(ReservationDTO reservationDTO) {
		return this.checkOut_date.compareToIgnoreCase(reservationDTO.getCheckOut_date());
	}
}

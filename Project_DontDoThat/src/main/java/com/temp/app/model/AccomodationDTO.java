package com.temp.app.model;

import java.io.Serializable;
import java.util.List;

public class AccomodationDTO implements Serializable {
	private int num;
	private int account_num;
	private String category_accomodation;
	private String homepage;
	private String headname;
	private String tel;
	private String accomodation_name;
	private String country;
	private String city;
	private String address;
	private String postalcode;
	private String accomodation_facility;
	private String image;
	private String content;
	private String policy;
	private String checkin_date;
	private String checkout_date;
	private String checkin_time;
	private String checkout_time;
	private String payment;
	private String nearby;
	private List<RoomDTO> roomList;
	private int minPrice;
	
	public int getNum() {
		return num;
	}
	public int getAccount_num() {
		return account_num;
	}
	public void setAccount_num(int account_num) {
		this.account_num = account_num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCategory_accomodation() {
		return category_accomodation;
	}
	public void setCategory_accomodation(String category_accomodation) {
		this.category_accomodation = category_accomodation;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public String getHeadname() {
		return headname;
	}
	public void setHeadname(String headname) {
		this.headname = headname;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAccomodation_name() {
		return accomodation_name;
	}
	public void setAccomodation_name(String accomodation_name) {
		this.accomodation_name = accomodation_name;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostalcode() {
		return postalcode;
	}
	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}
	public String getAccomodation_facility() {
		return accomodation_facility;
	}
	public void setAccomodation_facility(String accomodation_facility) {
		this.accomodation_facility = accomodation_facility;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPolicy() {
		return policy;
	}
	public void setPolicy(String policy) {
		this.policy = policy;
	}
	public String getCheckin_date() {
		return checkin_date;
	}
	public void setCheckin_date(String checkin_date) {
		this.checkin_date = checkin_date;
	}
	public String getCheckout_date() {
		return checkout_date;
	}
	public void setCheckout_date(String checkout_date) {
		this.checkout_date = checkout_date;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getNearby() {
		return nearby;
	}
	public void setNearby(String nearby) {
		this.nearby = nearby;
	}
	public List<RoomDTO> getRoomList() {
		return roomList;
	}
	public void setRoomList(List<RoomDTO> roomList) {
		this.roomList = roomList;
	}
	public String getCheckin_time() {
		return checkin_time;
	}
	public void setCheckin_time(String checkin_time) {
		this.checkin_time = checkin_time;
	}
	public String getCheckout_time() {
		return checkout_time;
	}
	public void setCheckout_time(String checkout_time) {
		this.checkout_time = checkout_time;
	}
	public int getMinPrice() {
		return minPrice;
	}
	public void setMinPrice(int minPrice) {
		this.minPrice = minPrice;
	}
}

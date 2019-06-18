package com.temp.app.model;

import java.util.ArrayList;
import java.util.List;

public class AccountDTO {
	
	//가입 필수 조건
	private int num;//회원번호?
	private String email;//이메일
	private String password;//비밀번호
	
	//숙소 예약 필수 조건
	private String name;//이름
	private String tel;//전화번호
	private String profilePhoto;//프로필 사진
	private String nickName;//닉네임
	private String birthday;//생일
	private String country;//국가
	private String countryName;//국가
	private String address;//주소
	private String payment;//결제 수단
	
	private List<Card> cardList;
	
	//선택 사항 - 여행 스타일
	private String smoke;//흡연 여부
	private int starRating;//숙소 성급
	private String disabled;//장애인 편의 시설 여부
	private String preferredFacility;//선호하는 시설
	private String reservationTarget;//예약 대상
	private String currency;//통화(원, 달러, 엔 등등)
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getProfilePhoto() {
		return profilePhoto;
	}
	public void setProfilePhoto(String profilePhoto) {
		this.profilePhoto = profilePhoto;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getSmoke() {
		return smoke;
	}
	public void setSmoke(String smoke) {
		this.smoke = smoke;
	}
	public int getStarRating() {
		return starRating;
	}
	public void setStarRating(int starRating) {
		this.starRating = starRating;
	}
	public String getDisabled() {
		return disabled;
	}
	public void setDisabled(String disabled) {
		this.disabled = disabled;
	}
	public String getPreferredFacility() {
		return preferredFacility;
	}
	public void setPreferredFacility(String preferredFacility) {
		this.preferredFacility = preferredFacility;
	}
	public String getReservationTarget() {
		return reservationTarget;
	}
	public void setReservationTarget(String reservationTarget) {
		this.reservationTarget = reservationTarget;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getCountryName() {
		return countryName;
	}
	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}
	public List<Card> getCardList() {
		return cardList;
	}
	public void setCardList(List<Card> cardList) {
		this.cardList = cardList;
	}

}


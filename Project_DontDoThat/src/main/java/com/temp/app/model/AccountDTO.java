package com.temp.app.model;

public class AccountDTO {
	
	//���� �ʼ� ����
	private int num;//ȸ����ȣ?
	private String email;//�̸���
	private String password;//��й�ȣ
	
	//���� ���� �ʼ� ����
	private String name;//�̸�
	private int tel;//��ȭ��ȣ
	private String profilePhoto;//������ ����
	private String nickName;//�г���
	private String birthday;//����
	private String country;//����
	private String address;//�ּ�
	private String payment;//���� ����
	
	//���� ���� - ���� ��Ÿ��
	private String smoke;//�� ����
	private int starRating;//���� ����
	private String disabled;//����� ���� �ü� ����
	private String preferredFacility;//��ȣ�ϴ� �ü�
	private String reservationTarget;//���� ���
	private String currency;//��ȭ(��, �޷�, �� ���)
	
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
	public int getTel() {
		return tel;
	}
	public void setTel(int tel) {
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
	
}

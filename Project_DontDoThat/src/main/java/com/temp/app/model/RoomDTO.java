package com.temp.app.model;

public class RoomDTO {
	private int num;
	//�����̸�
	private int accomodation_num;
	//���̸�
	private String roomname;
	//������
	private String roomclass;
	private int qty;
	private int currentQty;
	//�ο�
	private int people;
	private int price;
	//�ü�
	private String room_facility;
	private String room_image;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getAccomodation_num() {
		return accomodation_num;
	}
	public void setAccomodation_num(int accomodation_num) {
		this.accomodation_num = accomodation_num;
	}
	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
	}
	public String getRoom_facility() {
		return room_facility;
	}
	public void setRoom_facility(String room_facility) {
		this.room_facility = room_facility;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getRoom_image() {
		return room_image;
	}
	public void setRoom_image(String room_image) {
		this.room_image = room_image;
	}
	public int getCurrentQty() {
		return currentQty;
	}
	public void setCurrentQty(int currentQty) {
		this.currentQty = currentQty;
	}
}
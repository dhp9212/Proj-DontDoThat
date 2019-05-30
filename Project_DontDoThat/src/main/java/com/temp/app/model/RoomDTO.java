package com.temp.app.model;

public class RoomDTO {
	private int num;
	//숙소이름
	private int accomodation_num;
	//방이름
	private String roomname;
	//방종류
	private String roomclass;
	private int qty;
	//인원
	private int people;
	private int price;
	//시설
	private String room_facility;
	
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
}
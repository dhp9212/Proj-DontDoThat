package com.temp.app.model;

public class ReviewDTO {
	int num; 
	String writer;
	String subject; 
	String content_p;
	String content_m;
	String ip;
	int accommodation; 
	String lodge_date;
	String write_date;
	String image;
	int recom;
	int reply;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent_p() {
		return content_p;
	}
	public void setContent_p(String content_p) {
		this.content_p = content_p;
	}
	public String getContent_m() {
		return content_m;
	}
	public void setContent_m(String content_m) {
		this.content_m = content_m;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getAccommodation() {
		return accommodation;
	}
	public void setAccommodation(int accommodation) {
		this.accommodation = accommodation;
	}
	public String getLodge_date() {
		return lodge_date;
	}
	public void setLodge_date(String lodge_date) {
		this.lodge_date = lodge_date;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getRecom() {
		return recom;
	}
	public void setRecom(int recom) {
		this.recom = recom;
	}
	public int getReply() {
		return reply;
	}
	public void setReply(int reply) {
		this.reply = reply;
	}
}

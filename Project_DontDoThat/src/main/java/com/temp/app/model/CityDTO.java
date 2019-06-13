package com.temp.app.model;

import java.io.Serializable;

public class CityDTO  implements Serializable {
	private String country;
	private String country_name;
	private String city;
	private String city_image;
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
	public String getCity_image() {
		return city_image;
	}
	public void setCity_image(String city_image) {
		this.city_image = city_image;
	}
	public String getCountry_name() {
		return country_name;
	}
	public void setCountry_name(String country_name) {
		this.country_name = country_name;
	}
	
	
}

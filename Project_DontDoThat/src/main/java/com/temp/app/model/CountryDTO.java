package com.temp.app.model;

import java.io.Serializable;

public class CountryDTO implements Serializable {
	private String code_2;
	private String code_3;
	private String code_n;
	private String name;
	private String flag;
	
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getCode_2() {
		return code_2;
	}
	public void setCode_2(String code_2) {
		this.code_2 = code_2;
	}
	public String getCode_3() {
		return code_3;
	}
	public void setCode_3(String code_3) {
		this.code_3 = code_3;
	}
	public String getCode_n() {
		return code_n;
	}
	public void setCode_n(String code_n) {
		this.code_n = code_n;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}

package com.temp.app;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomepageController {
	
	@RequestMapping(value="hotelSuk.com")
	public String homepage1() {
		return "homepage/hotelSuk";
	}
	@RequestMapping(value="houseNue.com")
	public String homepage2() {
		return "homepage/houseNue";
	}
}

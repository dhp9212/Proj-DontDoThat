package com.myutil.app;

import java.util.Locale;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
    @Autowired
	 private JavaMailSender mailSender;
    
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	@RequestMapping(value = "star")
	public String star() {
		return "star";
	}
	@RequestMapping(value = "arrow")
	public String arrow() {
		return "arrow";
	}
	@RequestMapping(value = "mail")
	public String mail() {
		return "mail";
	}
	@RequestMapping(value = "mailSending.do")
	public String mailSending(HttpServletRequest req) {
		String setfrom = "lastwish31@gmail.com";         
	    String tomail  = req.getParameter("tomail");     // �޴� ��� �̸���
	    String title   = req.getParameter("title");      // ����
	    String content = req.getParameter("content");    // ����
	   
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom);  // �����»�� �����ϰų� �ϸ� �����۵��� ����
	      messageHelper.setTo(tomail);     // �޴»�� �̸���
	      messageHelper.setSubject(title); // ���������� ������ �����ϴ�
	      messageHelper.setText(content);  // ���� ����
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	   
	    return "redirect:mail";
	}
}

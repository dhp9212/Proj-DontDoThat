package com.temp.app;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.rmi.ServerException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.temp.app.model.AccountDTO;
import com.temp.app.model.CountryDTO;
import com.temp.app.service.AccomodationMapper;
import com.temp.app.service.AccountMapper;
import com.temp.app.service.StandardInformationMapper;

@Controller
public class AccountController {

	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private AccomodationMapper accomodationMapper; 
	@Autowired
	private StandardInformationMapper standardInformationMapper;
	
	@RequestMapping(value = "/signUp.do")
	public String signUpForm() {//ȸ�� ���� ��
		
		return "account/signUp";
	}
	
	//ȸ�� üũ
	@RequestMapping(value = "/checkAccount.do", method = RequestMethod.POST)
	public String checkAccountOk(HttpServletRequest req) {
		String email = req.getParameter("email");//�Էµ� email���� �����´�.
		HttpSession session = req.getSession();
		session.setAttribute("email", email);
		AccountDTO dto = accountMapper.checkEmail(email);
		if(dto == null) {
			System.out.println("AccountController�� checkAccount.do���� dto ���� null �Դϴ�. " + dto);
			req.setAttribute("email", email);
			return "account/passwordSettings";//ȸ���� �ƴ϶�� password.jsp �������� �̵�
		}else {
			System.out.println("AccountController�� checkAccount.do���� email �� : " + dto.getEmail());
			req.setAttribute("email", email);
			return "redirect:signUp.do";
		}
	}
	
	//�α��� �� �̵�
	@RequestMapping(value = "/login.do")
	public String login(HttpServletRequest req) {
		String email = req.getParameter("email");
		HttpSession session = req.getSession();
		session.setAttribute("email", email);
		if(email != null) {
			AccountDTO dto = accountMapper.checkEmail(email);
			req.setAttribute("email", dto.getEmail());
			req.setAttribute("email", email);
		}
		return "account/login";
	}
	
	//��й�ȣ �Է� ��
	@RequestMapping(value = "/password.do")
	public String password(HttpServletRequest req) {
		String ret = "";
		String email = req.getParameter("email");
		AccountDTO dto = accountMapper.checkEmail(email);
		if(dto == null) { 
			String none = "����";
			req.setAttribute("emailCheckNone", none);
			ret = "account/login";
		}else {
			System.out.println("is there:" + dto.getEmail());
			req.setAttribute("email", email);
			req.getSession().setAttribute("dto", dto);
			ret = "account/password";
		}		
		return ret;
	}
	
	//�α��� Ok(��й�ȣ �Է� ��)
	@RequestMapping(value = "/loginOk.do")
	public ModelAndView loginOk(HttpServletRequest req) throws Exception {
		HttpSession session = req.getSession();
		ModelAndView mv = new ModelAndView();
		
		
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		AccountDTO dto = (AccountDTO)session.getAttribute("dto");
				
		if(dto.getPassword().equals(password)) {
			session.setAttribute("userSession", dto);
			//�ڱ� �̸��� �´� ���� ����Ʈ ���ǵ��
			session.setAttribute("accomodation_list", accomodationMapper.getAccomodation(dto.getNum()));
			mv.setViewName("forward:/");
		}else {
			String wrongPassword = "��й�ȣ Ʋ��";
			req.setAttribute("email", dto.getEmail());
			req.setAttribute("wrongPassword", wrongPassword);
			mv.setViewName("account/password");
		}
		return mv;
	}
	
	//�α׾ƿ�
	@RequestMapping(value="logoutOk.do")
	public ModelAndView logout(HttpServletRequest req) throws Exception{
		req.getSession().removeAttribute("email");
		req.getSession().removeAttribute("userSession");
		ModelAndView mav = new ModelAndView("account/login");
		return mav;
	}
	
	//��й�ȣ ���� �Ϸ�
	@RequestMapping(value = "/passwordSettingsOk.do", method = RequestMethod.POST)
	public ModelAndView passwordOk(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String password = req.getParameter("setPassword");
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("dto");
		session.setAttribute("userSession", dto);
		dto.setEmail((String)session.getAttribute("email"));
		dto.setPassword(password);
		dto.setName("");
		dto.setTel(0);
		dto.setProfilePhoto("");
		dto.setNickName("");
		dto.setBirthday("");
		dto.setCountry("");
		dto.setAddress("");
		dto.setPayment("");
		dto.setSmoke("");
		dto.setStarRating(0);
		dto.setDisabled("");
		dto.setPreferredFacility("");
		dto.setReservationTarget("");
		dto.setCurrency("");
		int res = accountMapper.insertAccount(dto);
		mav.addObject(res);
		mav.setViewName("account/mySettings");
		return mav;
	}
	
	//�� ���� ���� �������� �̵�
	@RequestMapping(value = "/mySettings.do")
	public String mySettings(HttpServletRequest req) {
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		req.setAttribute("profilePhoto", dto.getProfilePhoto());
		req.setAttribute("nickName", dto.getNickName());
		req.setAttribute("birthday", dto.getBirthday());
		
//		if(dto.getCountry() != null) {
//			CountryDTO cdto = standardInformationMapper.getCountryByCode2(dto.getCountry());
//			if(cdto == null) {
//				req.setAttribute("country", "���� ����");
//			}else {
//				req.setAttribute("country", cdto.getName());
//			}
//		}
		//System.out.println("dto.getCountry ��Ʈ�ѷ� ���� �� : " + dto.getCountry());
		
		return "account/mySettings";
	}
	
	//������ ���ΰ�ħ ���� ���ε� ������... ������ ���� ������ (�г��� ��)
	@RequestMapping(value = "/accountUpdate.do")
	public ModelAndView accountUpdateOk(HttpServletRequest req) throws IOException,ServerException {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		int num = dto.getNum();
		dto.setNum(num);
		int res = 0;
		
		
		//MultipartRequest mr = null;
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)req;
		if(mhsr == null) {
			System.out.println("���� null�� üũ" + mhsr);
		}else {
			MultipartFile mf  = mhsr.getFile("profilePhoto");
			String path = req.getSession().getServletContext().getRealPath("/resources/img/profileImage/");//"D:\\maven\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_DontDoThat\\resources\\img\\profileImage";//req.getRealPath("/resources/img/profileImage");//"d:/image/";
			if(mf != null) {
				String organizedfilePath= "";
				try {
					if(mf.getSize() > 0) {
						organizedfilePath = mf.getOriginalFilename();
						File realUpload = new File(path, organizedfilePath);
						if(!realUpload.exists()) {
							realUpload.mkdirs();
						}
						mf.transferTo(realUpload);
						
						dto.setProfilePhoto(organizedfilePath);
						accountMapper.updateProfilePhoto(dto);
						req.setAttribute("profilePhoto", dto.getProfilePhoto());
						System.out.println("������ �̹��� �� : " + dto.getProfilePhoto());
						System.out.println("���� null�� üũ" + mhsr);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}else {
				req.setAttribute("profilePhoto", dto.getProfilePhoto());
			}
		}
		
		String nickName = req.getParameter("nickName");//�г���
		String birthday = req.getParameter("birthday");//����
		String country = req.getParameter("country");//����/����
		
		String name = req.getParameter("name");//�̸�
		String tel = req.getParameter("tel");//��ȭ��ȣ
		
		String address = req.getParameter("address");//�ּ�
		String payment = req.getParameter("payment");//��������
		String smoke = req.getParameter("smoke");//�� ����
		String starRating = req.getParameter("starRating");//���� ����
		String disabled = req.getParameter("disabled");//����� ���� �ü� ����
		String preferredFacility = req.getParameter("preferredFacility");//��ȣ�ϴ� �ü�
		String reservationTarget = req.getParameter("reservationTarget");//���� ���
		
		String currency = req.getParameter("currency");//��ȭ(��, �޷�, ��)���
		String password = req.getParameter("password");//��й�ȣ
		
		
		if(nickName == null || nickName.trim().equals("")) {
			System.out.println("nickName = " + nickName);
		}else {
			System.out.println("nickName = " + nickName);
			dto.setNickName(req.getParameter("nickName"));
			accountMapper.updateNickName(dto);
			req.setAttribute("nickName", dto.getNickName());
		}
		
		
		if(birthday == null || birthday.trim().equals("")) {
			System.out.println("birthday = " + birthday);
		}else {
			System.out.println("birthday = " + birthday);
			dto.setBirthday(req.getParameter("birthday"));
			accountMapper.updateBirthday(dto);
			System.out.println("dto.getBirthday : " + dto.getBirthday());
			req.setAttribute("birthday", dto.getBirthday());
		}
		
		if(country == null || country.trim().equals("")) {
			System.out.println("country = " + country);
		}else {
			System.out.println("country = " + country);
			dto.setCountry(req.getParameter("country"));
			accountMapper.updateCountry(dto);
//			CountryDTO cdto = standardInformationMapper.getCountryByCode2(dto.getCountry());
//			System.out.println("DB���� �Ϸ�? : " + country);
//			System.out.println("DB���� �Ϸ�? : " + dto.getCountry());
//			System.out.println("co : " + cdto.getName());
//			req.setAttribute("country", cdto.getName());
		}
		
		if(name == null || name.trim().equals("")) {
			System.out.println("name = " + name);
		}else {
			System.out.println("name = " + name);
			dto.setName(req.getParameter("name"));
			//accountMapper.updateName(dto);
			req.setAttribute("name", dto.getName());
		}
		
		if(tel == null || tel.trim().equals("")) {
			System.out.println("tel = " + tel);
		}else {
			System.out.println("tel = " + tel);
			dto.setTel(Integer.parseInt(req.getParameter("tel")));
			//accountMapper.updateName(dto);
			req.setAttribute("tel", dto.getTel());
		}
		
		if(address == null || address.trim().equals("")) {
			System.out.println("address = " + address);
		}else {
			System.out.println("address = " + address);
			dto.setAddress(req.getParameter("address"));
			//accountMapper.updateAddress(dto);
			req.setAttribute("address", dto.getAddress());
		}
		
		if(payment == null || payment.trim().equals("")) {
			System.out.println("payment = " + payment);
		}else {
			System.out.println("payment = " + payment);
			dto.setPayment(req.getParameter("payment"));
			//accountMapper.updatePayment(dto);
			req.setAttribute("payment", dto.getPayment());
		}
		
		if(smoke == null || smoke.trim().equals("")) {
			System.out.println("smoke = " + smoke);
		}else {
			System.out.println("smoke = " + smoke);
			dto.setSmoke(req.getParameter("smoke"));
			//accountMapper.updateSmoke(dto);
			req.setAttribute("smoke", dto.getSmoke());
		}
		
		if(starRating == null || starRating.trim().equals("")) {
			System.out.println("starRating = " + starRating);
		}else {
			System.out.println("starRating = " + starRating);
			dto.setStarRating(Integer.parseInt(req.getParameter("starRating")));
			//accountMapper.updateStarRating(dto);
			req.setAttribute("starRating", dto.getStarRating());
		}
		
		if(disabled == null || disabled.trim().equals("")) {
			System.out.println("disabled = " + disabled);
		}else {
			System.out.println("disabled = " + disabled);
			dto.setDisabled(req.getParameter("disabled"));
			//accountMapper.updateDisabled(dto);
			req.setAttribute("disabled", dto.getDisabled());
		}
		
		if(preferredFacility == null || preferredFacility.trim().equals("")) {
			System.out.println("preferredFacility = " + preferredFacility);
		}else {
			System.out.println("preferredFacility = " + preferredFacility);
			dto.setPreferredFacility(req.getParameter("preferredFacility"));
			//accountMapper.updatePreferredFacility(dto);
			req.setAttribute("preferredFacility", dto.getPreferredFacility());
		}
		
		if(reservationTarget  == null || reservationTarget .trim().equals("")) {
			System.out.println("reservationTarget  = " + reservationTarget );
		}else {
			System.out.println("reservationTarget  = " + reservationTarget );
			dto.setReservationTarget (req.getParameter("reservationTarget "));
			//accountMapper.updateReservationTarget(dto);
			req.setAttribute("reservationTarget", dto.getReservationTarget());
		}
		
		if(currency == null || currency.trim().equals("")) {
			System.out.println("currency = " + currency);
		}else {
			System.out.println("currency = " + currency);
			dto.setCurrency(req.getParameter("currency"));
			//accountMapper.updateCurrency(dto);
			req.setAttribute("currency", dto.getCurrency());
		}
		
		if(password == null || password.trim().equals("")) {
			System.out.println("password = " + password);
		}else {
			System.out.println("password = " + password);
			dto.setPassword(req.getParameter("password"));
			//accountMapper.updatePassword(dto);
			req.setAttribute("password", dto.getPassword());
		}
		mav.setViewName("account/mySettings");
		return mav;
	}
	
	
	//�̿� ���
	@RequestMapping(value = "/terms.do")
	public String terms() {
		return "account/terms";
	}
	
	//�������� ��ȣ��å
	@RequestMapping(value = "/privacy.do")
	public String privacy() {
		return "account/privacy";
	}
	
	//�׽�Ʈ ������
	@RequestMapping(value = "/testPage.do")
	public String testPage() {
		return "test/testPage";
	}
}

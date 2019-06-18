package com.temp.app;

import java.io.File;
import java.io.IOException;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.temp.app.model.AccountDTO;
import com.temp.app.model.Card;
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
	@Autowired
	 private JavaMailSender mailSender;
	
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
	
		req.getSession().setAttribute("email", email);
		
		// get Account Data
		AccountDTO dto = accountMapper.checkEmail(email);
		
		if(dto == null) {
			// not exist email = not a member
			String none = "����";
			req.setAttribute("emailCheckNone", none);
			ret = "account/login";
		}else {
			// exist email = member
			req.setAttribute("email", email);
			req.getSession().setAttribute("dto", dto);
			ret = "account/password";
		}		
		return ret;
	}
	
	//�ӽ� ��й�ȣ �߼�
		@RequestMapping(value = "/temporaryPassword.do")
		public ModelAndView temporaryPassword(HttpServletRequest req) {
			HttpSession session = req.getSession();
			AccountDTO dto = (AccountDTO)session.getAttribute("dto");
			ModelAndView mv = new ModelAndView();
				
		    String uuid = UUID.randomUUID().toString().replaceAll("-", ""); // -�� ������ �־���. 
		    uuid = uuid.substring(0, 10); //uuid�� �տ������� 10�ڸ� �߶���. 
			    
			String setfrom = "Gnikcah6@gmail.com";         
		    String tomail  = (String)session.getAttribute("email");     // �޴� ��� �̸���
		    String title   = "�ӽ� ��й�ȣ";    // ����
		    String content = uuid;   // ����
		    System.out.println("�ӽ� ��й�ȣ ���� = " + uuid);
		    dto.setPassword(uuid);
		    accountMapper.updateTemporaryPassword(dto);
		    
		    System.out.println("session �̸��� �� : " + tomail);
		    System.out.println("�ӽ� ��й�ȣ ������Ʈ = " + dto.getPassword());
		    try {
		      MimeMessage message = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		 
		      messageHelper.setFrom(setfrom);  // �����»�� �����ϰų� �ϸ� �����۵��� ����
		      messageHelper.setTo(tomail);     // �޴»�� �̸���
		      messageHelper.setSubject(title); // ���������� ������ �����ϴ�
		      messageHelper.setText(content);  // ���� ����
		     
		      mailSender.send(message);
		    } catch(Exception e){
		      //System.err.println(e);
		    }
		    mv.setViewName("account/password");
		    return mv; 
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
			
			// if country exist
			if(dto.getCountry() != null && !dto.getCountry().equals("")) {
				dto.setCountryName(standardInformationMapper.getCountryByCode2(dto.getCountry()).getName());
			}
			
			session.setAttribute("userSession", dto);
			System.out.println("payment zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz : " + dto.getPayment());
			// if credit card exist
			if(dto.getPayment() != null) {
				if(!dto.getPayment().equals("")) {
					List<Card> cardList = new ArrayList<Card>();
					String[] cards = dto.getPayment().split("#");
					for(int i = 0; i < cards.length; i++) {
						String[] cardElement = cards[i].split(",");
						System.out.println("cardlength : " +cards.length);
						cardList.add(new Card(cardElement[0], cardElement[1], cardElement[2]));
					}
					dto.setCardList(cardList);
				}
			}
			
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
		ModelAndView mav = new ModelAndView("redirect:/");
		return mav;
	}
	
	//��й�ȣ ���� �Ϸ�
	@RequestMapping(value = "/passwordSettingsOk.do", method = RequestMethod.POST)
	public ModelAndView passwordOk(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String password = req.getParameter("setPassword");
		HttpSession session = req.getSession();
		AccountDTO dto = new AccountDTO();
		dto.setEmail((String)session.getAttribute("email"));
		dto.setPassword(password);
		dto.setName("");
		dto.setTel("");
		dto.setProfilePhoto("");
		dto.setNickName("");
		dto.setBirthday("");
		dto.setCountry("");
		dto.setAddress("");
		dto.setPayment(null);
		dto.setSmoke("");
		dto.setStarRating(0);
		dto.setDisabled("");
		dto.setPreferredFacility("");
		dto.setReservationTarget("");
		dto.setCurrency("");
		session.setAttribute("userSession", dto);
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
	
		return "account/mySettings";
	}
	
//	//������ ���� ������
//	@RequestMapping(value = "/accountUpdate.do")
//	public ModelAndView accountUpdateOk(HttpServletRequest req) throws IOException,ServerException {
//		ModelAndView mav = new ModelAndView();
//		HttpSession session = req.getSession();
//		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
//		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)req;
//		
//		MultipartFile mf  = mhsr.getFile("profilePhoto");
//		String path = req.getSession().getServletContext().getRealPath("/resources/img/profileImage/");
//		//"D:\\maven\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_DontDoThat\\resources\\img\\profileImage";//req.getRealPath("/resources/img/profileImage");//"d:/image/";
//		if(mf != null) {
//			String organizedfilePath= "";
//			try {
//				if(mf.getSize() > 0) {
//					organizedfilePath = mf.getOriginalFilename();
//					File realUpload = new File(path, organizedfilePath);
//					if(!realUpload.exists()) {
//						realUpload.mkdirs();
//					}
//					mf.transferTo(realUpload);
//					
//					dto.setProfilePhoto(organizedfilePath);
//					accountMapper.updateProfilePhoto(dto);
//					req.setAttribute("profilePhoto", dto.getProfilePhoto());
//					System.out.println("������ �̹��� �� : " + dto.getProfilePhoto());
//					System.out.println("���� null�� üũ" + mhsr);
//				}
//			}catch(Exception e) {
//				e.printStackTrace();
//			}
//		}else {
//			req.setAttribute("profilePhoto", dto.getProfilePhoto());
//		}
//		
//		String nickName = req.getParameter("nickName");//�г���
//		String birthday = req.getParameter("birthday");//����
//		String country = req.getParameter("country");//����/����
//		
//		String name = req.getParameter("name");//�̸�
//		String tel = req.getParameter("tel");//��ȭ��ȣ
//		String email = req.getParameter("email");//�̸���
//		String address = req.getParameter("address");//�ּ�
//		
//		String selectPayment = req.getParameter("payment");//ī�� ����
//		String nameOfCreditCard = req.getParameter("nameOfCreditCard");//ī�� ��ȣ
//		String expirationDate = req.getParameter("expirationDate");//���� ����
//
//		
//		String payment = selectPayment + " " + nameOfCreditCard + " " + expirationDate;//��������
//		String smoke = req.getParameter("smoke");//�� ����
//		String starRating = req.getParameter("starRating");//���� ����
//		String disabled = req.getParameter("disabled");//����� ���� �ü� ����
//		String preferredFacility = req.getParameter("preferredFacility");//��ȣ�ϴ� �ü�
//		String reservationTarget = req.getParameter("reservationTarget");//���� ���
//		
//		String currency = req.getParameter("currency");//��ȭ(��, �޷�, ��)���
//		String password = req.getParameter("confirmPassword");//��й�ȣ
//		
//		
//		session.getAttribute("currencyList");
//		
//		if(nickName != null) {// || !nickName.trim().equals("")
//			System.out.println("nickName = " + nickName);
//			dto = (AccountDTO)session.getAttribute("userSession");
//			dto.setNickName(req.getParameter("nickName"));
//			accountMapper.updateNickName(dto);
//			req.setAttribute("nickName", dto.getNickName());
//			System.out.println("birthday = " + birthday);
//			dto.setBirthday(req.getParameter("birthday"));
//			accountMapper.updateBirthday(dto);
//			System.out.println("dto.getBirthday : " + dto.getBirthday());
//			req.setAttribute("birthday", dto.getBirthday());
//		}else if(country != null){
//			System.out.println("country = " + country);
//			dto.setCountry(req.getParameter("country"));
//			//accountMapper.updateCountry(dto);			
//			req.setAttribute("country", dto.getCountry());
//		}else if(name != null) {
//			System.out.println("name = " + name);
//			dto.setName(req.getParameter("name"));
//			accountMapper.updateName(dto);
//			req.setAttribute("name", dto.getName());
//			System.out.println("tel = " + tel);
//			dto.setTel(req.getParameter("tel"));
//			accountMapper.updateTel(dto);
//			req.setAttribute("tel", dto.getTel());
//			System.out.println("address = " + address);
//			dto.setAddress(req.getParameter("address"));
//			accountMapper.updateAddress(dto);
//			req.setAttribute("address", dto.getAddress());
//		}else if(payment != null || !payment.trim().equals("")) {
//			System.out.println("payment = " + payment);
//			
//			dto.setPayment(payment);
//			accountMapper.updatePayment(dto);
//			
//			// 0 : kind of card
//			// 1 : # of card
//			// 2 : expire date
////			String[] pay = payment.split(" ");
////			req.setAttribute("selectCard", pay[0]);
////			req.setAttribute("nameOfCreditCard", pay[1]);
////			req.setAttribute("expirationDate", pay[2]);
//			req.setAttribute("payment", dto.getPayment());
//		}else if(smoke != null || !smoke.trim().equals("")) {
//			System.out.println("smoke = " + smoke);
//			dto.setSmoke(req.getParameter("smoke"));
//			//accountMapper.updateSmoke(dto);
//			req.setAttribute("smoke", dto.getSmoke());
//		}else if(starRating != null || !starRating.trim().equals("")) {
//			System.out.println("starRating = " + starRating);
//			dto.setStarRating(Integer.parseInt(req.getParameter("starRating")));
//			//accountMapper.updateStarRating(dto);
//			req.setAttribute("starRating", dto.getStarRating());
//		}else if(disabled != null || !disabled.trim().equals("")) {
//			System.out.println("disabled = " + disabled);
//			dto.setDisabled(req.getParameter("disabled"));
//			//accountMapper.updateDisabled(dto);
//			req.setAttribute("disabled", dto.getDisabled());
//		}else if(preferredFacility != null || !preferredFacility.trim().equals("")) {
//			System.out.println("preferredFacility = " + preferredFacility);
//			dto.setPreferredFacility(req.getParameter("preferredFacility"));
//			//accountMapper.updatePreferredFacility(dto);
//			req.setAttribute("preferredFacility", dto.getPreferredFacility());
//		}else if(reservationTarget  != null || !reservationTarget .trim().equals("")) {
//			System.out.println("reservationTarget  = " + reservationTarget );
//			dto.setReservationTarget (req.getParameter("reservationTarget "));
//			//accountMapper.updateReservationTarget(dto);
//			req.setAttribute("reservationTarget", dto.getReservationTarget());
//		}else if(currency != null || !currency.trim().equals("")) {
//			System.out.println("currency = " + currency);
//			dto.setCurrency(req.getParameter("currency"));
//			//accountMapper.updateCurrency(dto);
//			req.setAttribute("currency", dto.getCurrency());
//		}else if(password != null || !password.trim().equals("")) {
//			System.out.println("password = " + password);
//			dto.setPassword(req.getParameter("confirmPassword"));
//			accountMapper.updatePassword(dto);
//			req.setAttribute("password", dto.getPassword());
//		}
//		
////		if(password == null || password.trim().equals("")) {
////			System.out.println("password = " + password);
////		}else {
////			System.out.println("password = " + password);
////			dto.setPassword(req.getParameter("confirmPassword"));
////			accountMapper.updatePassword(dto);
////			req.setAttribute("password", dto.getPassword());
////		}
//		
//		mav.setViewName("forward:/mySettings.do");
//		return mav;
//	}
	
	
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
	
	
	
	@RequestMapping(value = "/accountUpdateImage.do")
	public ModelAndView accountUpdateImage(HttpServletRequest req) throws IOException,ServerException {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest)req;
		
		MultipartFile mf  = mhsr.getFile("profilePhoto");
		String path = req.getSession().getServletContext().getRealPath("/resources/img/profileImage/");
		//"D:\\maven\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Project_DontDoThat\\resources\\img\\profileImage";//req.getRealPath("/resources/img/profileImage");//"d:/image/";
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
		
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	@RequestMapping(value = "/accountUpdateNames.do")
	public ModelAndView accountUpdateNames(HttpServletRequest req) throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String nickName = req.getParameter("nickName");//�г���
		String birthday = req.getParameter("birthday");//����
		
		// if nickName form is not null, update DB
		if(nickName != null) {
			dto.setNickName(nickName);
			accountMapper.updateNickName(dto);
		}
		// if birthday form is not null, update DB
		if(birthday != null) {
			dto.setBirthday(birthday);
			accountMapper.updateBirthday(dto);
		}
		
		session.setAttribute("userSession", dto);
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	@RequestMapping(value = "/accountUpdateCountry.do")
	public ModelAndView accountUpdateCountry(HttpServletRequest req) throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String countryCode2 = req.getParameter("country");
		
		dto.setCountry(countryCode2);
		accountMapper.updateCountry(dto);
		dto.setCountryName(standardInformationMapper.getCountryByCode2(countryCode2).getName());
		
		session.setAttribute("userSession", dto);
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	@RequestMapping(value = "/accountUpdatePrivate.do")
	public ModelAndView accountUpdatePrivate(HttpServletRequest req) throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String name = req.getParameter("name");
		String tel = req.getParameter("tel");
		String address = req.getParameter("address");
		
		
		if(name != null) {
			dto.setName(name);
			accountMapper.updateName(dto);
		}
		
		if(tel != null) {
			dto.setTel(tel);
			accountMapper.updateTel(dto);
		}
		
		if(address != null) {
			dto.setAddress(address);
			accountMapper.updateAddress(dto);
		}
		
		session.setAttribute("userSession", dto);
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	
	@RequestMapping(value = "/accountUpdateCard.do")
	public ModelAndView accountUpdateCard(HttpServletRequest req) throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String kindOfCreditCard = req.getParameter("kindOfCreditCard");
		String numOfCreditCard = req.getParameter("numOfCreditCard");
		String expirationDate = req.getParameter("expirationDate");
		
		System.out.println("here");
		
		String payment = dto.getPayment();
		
		// if payment already exist add tokenizer /
		if(payment != null) {
			if(!payment.equals("")) {
				payment += "#";
			}
		}
		else {
			payment = "";
		}
		payment += kindOfCreditCard + ",";
		payment += numOfCreditCard + ",";
		payment += expirationDate;
		
		dto.setPayment(payment);
		accountMapper.updatePayment(dto);
		
		List<Card> cardList;
		if(dto.getCardList() == null) {
			cardList = new ArrayList<Card>();
		}
		else {
			cardList = dto.getCardList();
		}
		cardList.add(new Card(kindOfCreditCard, numOfCreditCard, expirationDate));
		dto.setCardList(cardList);
		
		session.setAttribute("userSession", dto);
		mav.setViewName("forward:/mySettings.do");
		return mav;
	}
	
	@RequestMapping(value = "accountUpdatePassword.do")
	public ModelAndView accountUpdatePassword(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		AccountDTO dto = (AccountDTO)session.getAttribute("userSession");
		
		String password = req.getParameter("confirmPassword");//��й�ȣ
		if(password != null || !password.trim().equals("")) {
			System.out.println("password = " + password);
			dto.setPassword(req.getParameter("confirmPassword"));
			accountMapper.updatePassword(dto);
			req.setAttribute("password", dto.getPassword());
		}
		
		mav.setViewName("forward:/mySettings.do");
		
		return mav;
	}
}

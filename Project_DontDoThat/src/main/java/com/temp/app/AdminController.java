package com.temp.app;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.temp.app.model.QA_AnswerDTO;
import com.temp.app.model.QA_SubCateDTO;
import com.temp.app.service.AccountMapper;
import com.temp.app.service.CustomServiceMapper;

@Controller
public class AdminController {
	@Autowired
	private AccountMapper accountMapper;
	@Autowired
	private CustomServiceMapper customServiceMapper;
	

	
	@RequestMapping(value = "/adminMain.do")
	public String adminmain() throws Exception{
		return "admin/main";
	}
	@RequestMapping(value = "/Q&A.admin")
	public String questionAnswer(HttpServletRequest req) throws Exception {
		try {
			List<String> maincatelist = customServiceMapper.getMainCategory();
			req.setAttribute("hcatelist", maincatelist);
			for(String h : maincatelist) {
				List<QA_SubCateDTO> subcatelist = customServiceMapper.getSubCategory(h);
				req.setAttribute(h, subcatelist);
			}
			return "admin/Q&A";
		}catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("msg", "DB서버 오류 발생!! 관리자에게 문의하세요");
			req.setAttribute("url", "start.app");
			return "message";
		}
	}
	@RequestMapping(value="inputMainCate_Ok.admin")
	public String inputMainCateOk(HttpServletRequest req) throws Exception{
		String maincate = req.getParameter("hcate");
		String subcate = req.getParameter("mcate");
		String msg = null, url = "Q&A.admin";
			try {
				if (subcate == null) {
				int res = customServiceMapper.insertMainCategory(maincate);
					if(res>0) {
						msg = "카테고리 등록 성공!!";
					}else {
						msg = "카테고리 등록 실패!!";
					}
				}else {
				int res = customServiceMapper.insertSubCategory(maincate, subcate);
					if(res>0) {
						msg = "카테고리 등록 성공!!";
					}else {
						msg = "카테고리 등록 실패!!";
					}
				}
			}catch (Exception e) {
				e.printStackTrace();
				msg = "DB서버 오류 발생!! 관리자에게 문의하세요";
				url = "start.app";
			}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	@RequestMapping(value="/inputAnswer.admin")
	public String inputAnswer(HttpServletRequest req) throws Exception {
		QA_AnswerDTO dto = new QA_AnswerDTO();
		dto.setMaincate(req.getParameter("hcate"));
		dto.setSubcate(Integer.parseInt(req.getParameter("mcate")));
		dto.setAnswer(req.getParameter("answer"));
		String msg = null, url = null;
		try {
			int res = customServiceMapper.inputAnswer(dto);
			if(res>0) {
				return "forward:listAnswer.admin";
			}else {
				msg = "카테고리 등록 실패!!";
				url =  "Q&A.admin";
			}
		}catch (Exception e) {
			e.printStackTrace();
			msg = "DB서버 오류 발생!! 관리자에게 문의하세요";
			url = "start.app";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	@RequestMapping(value="/deleteAnswer")
	public String deleteAnswer(HttpServletRequest req) throws Exception{
		String no = req.getParameter("no");
		String msg = null, url = null;
		try {
			int res = customServiceMapper.deleteAnswer(Integer.parseInt(no));
			if(res>0) {
				return "forward:listAnswer.admin";
			}else {
				msg = "카테고리 삭제 실패!!";
				url =  "forward:listAnswer.admin";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "DB서버 오류 발생!! 관리자에게 문의하세요";
			url = "start.app";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	
	@RequestMapping(value="/deleteCate.admin")
	public String deleteCate(HttpServletRequest req) throws Exception{
		String maincate = req.getParameter("hcate");
		String no = req.getParameter("no");
		int res=0;
		String msg = null, url = null;
		try {
			if(no == null) {
				res = customServiceMapper.deleteMainCate(maincate);
				res = customServiceMapper.deleteMainCate1(maincate);
			}else {
				res = customServiceMapper.deleteSubCate(no);
			}
			if(res>0) {
				return "redirect:Q&A.admin";
			}else {
				msg = "카테고리 삭제 실패!!";
				url = "Q&A.admin";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "DB서버 오류 발생!! 관리자에게 문의하세요";
			url = "start.app";
		}
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	@RequestMapping(value="/listAnswer.admin")
	public String listAnswer(HttpServletRequest req) throws Exception{
		String h = req.getParameter("hcate");
		String m = req.getParameter("mcate");
		try {
			List<String> maincatelist = customServiceMapper.getMainCategory();
			req.setAttribute("hcatelist", maincatelist);
			for(String r : maincatelist) {
				List<QA_SubCateDTO> subcatelist = customServiceMapper.getSubCategory(r);
				req.setAttribute(r, subcatelist);
			}
			List<QA_AnswerDTO> bcate = customServiceMapper.getAnswer(Integer.parseInt(m));
			req.setAttribute("bcate", bcate);
			req.setAttribute("hcate", h);
			req.setAttribute("mcate", m);
			return "forward:Q&A.admin";
		} catch (Exception e) {
			e.printStackTrace();
			req.setAttribute("msg", "DB서버 오류 발생!! 관리자에게 문의하세요");
			req.setAttribute("url", "start.app");
			return "message";
		}
	}
}

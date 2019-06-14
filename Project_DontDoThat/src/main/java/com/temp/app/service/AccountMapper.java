package com.temp.app.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.app.model.AccountDTO;

@Service
public class AccountMapper {
	
	@Autowired
	private SqlSession sqlSession;

	public int insertAccount(AccountDTO dto) {	
		return sqlSession.insert("insertAccount", dto);
	}
	
	public AccountDTO getAccount(int num) {
		return sqlSession.selectOne("getAccount", num);
	}
	
	public AccountDTO getAccount(AccountDTO dto) {
		return sqlSession.selectOne("getAccountByDTO", dto);
	}
	
	public List<AccountDTO> memberList(){
		return sqlSession.selectList("memberList");
	}
	
	public AccountDTO checkEmail(String email) {
		return sqlSession.selectOne("checkEmail", email);
	}
	
	public AccountDTO checkPassword(String password) {
		return sqlSession.selectOne("checkPassword", password);
	}
	
//	public void updateAccount(AccountDTO dto) {
//		try {
//			System.out.println("������");
//			sqlSession.update("updateAccountNick", dto);
//			System.out.println("������");
//			
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
////		return sqlSession.update("updateAccount", dto);
//	}
	
	public void updateProfilePhoto(AccountDTO dto) {
		sqlSession.update("updateProfilePhoto", dto);
	}
	
	public void updateNickName(AccountDTO dto) {
		try {
			System.out.println("mapper updateNickName ���� ��");
			sqlSession.update("updateNickName", dto);
			System.out.println("mapper updateNickName ���� ��");
		}catch(Exception e) {
			System.err.println("�г��� ��������");
			e.printStackTrace();
		}
	}
	
	public void updateBirthday(AccountDTO dto) {
		sqlSession.update("updateBirthday", dto);
	}
	
	public void updateCountry(AccountDTO dto) {
		sqlSession.update("updateCountry", dto);
	}
	
	public void updateName(AccountDTO dto) {
		sqlSession.update("updateName", dto);
	}
	
	public void updateTel(AccountDTO dto) {
		sqlSession.update("updateTel", dto);
	}
	
	public void updateAddress(AccountDTO dto) {
		sqlSession.update("updateAddress", dto);
	}
	
	public void updatePassword(AccountDTO dto) {
		sqlSession.update("updatePassword", dto);
	}
	
	public void updatePayment(AccountDTO dto) {
		sqlSession.update("updatePayment", dto);
	}
	
//	protected List<AccountDTO> makeList(){
//		return sqlSession.selectList("makeList", )
//	}
}

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
	
	public List<AccountDTO> memberList(){
		return sqlSession.selectList("memberList");
	}
	
	public AccountDTO checkEmail(String email) {
		return sqlSession.selectOne("checkEmail", email);
	}
	
	public AccountDTO checkPassword(String password) {
		return sqlSession.selectOne("checkPassword", password);
	}
	
	public int updateAccount(AccountDTO dto) {
		return sqlSession.update("updateAccount", dto);
	}
	
//	protected List<AccountDTO> makeList(){
//		return sqlSession.selectList("makeList", )
//	}
}

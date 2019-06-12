package com.temp.app.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.temp.app.model.MessageDTO;

@Service
public class MessageMapper {
	@Autowired
	private SqlSession sqlSession;
	
	public List<MessageDTO> listMessage(String mbId){
		return sqlSession.selectList("listMessage", mbId);
	}
	public int writeMessage(MessageDTO dto) {
		return sqlSession.insert("writeMessage", dto);
	}
	public int deleteMessage(int no) {
		return sqlSession.delete("deleteMessage", no);
	}
}

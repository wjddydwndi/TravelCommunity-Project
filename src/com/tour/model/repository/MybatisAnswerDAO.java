package com.tour.model.repository;

import java.sql.Connection;
import java.sql.SQLException;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.domain.Answer;

@Repository
public class MybatisAnswerDAO implements AnswerDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public int insert(Answer answer) {
		int result = sqlSessionTemplate.insert("Answer.insert", answer);
		
		return result;
	}

	@Override
	public int delete(int answer_id) {
		int result = sqlSessionTemplate.delete("Answer.delete", answer_id);
		return result;
	}

	@Override
	public Answer select(int answer_id) {
		Answer answer = sqlSessionTemplate.selectOne("Answer.select", answer_id);
		return answer;
	}

	@Override
	public int update(Answer answer) {
		int result = sqlSessionTemplate.update("Answer.update", answer);
		return result;
	}

	@Override
	public int delete2(int qnaboard_id) {
		int result = sqlSessionTemplate.delete("Answer.delete2", qnaboard_id);
		return result;
	}

}

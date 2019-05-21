package com.tour.model.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Repository;

import com.tour.model.domain.QnABoardPrivacyPass;

@Repository
public class MybatisQnABoardPrivacyPassDAO implements QnABoardPrivacyPassDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTempalte;
	
	@Override
	public String select(int qnaboard_id) {
		String pass = sqlSessionTempalte.selectOne("QnABoardPrivacyPass.select", qnaboard_id);
		return pass;
	}

	@Override
	public int insert(QnABoardPrivacyPass qnaBoard_privacy_pass) {
		int result = sqlSessionTempalte.insert("QnABoardPrivacyPass.insert", qnaBoard_privacy_pass);
		return result;
	}

	@Override
	public int delete(int qnaBoard_id) {
		int result = sqlSessionTempalte.delete("QnABoardPrivacyPass.delete", qnaBoard_id);
		return result;
	}

}

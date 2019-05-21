package com.tour.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tour.exception.DataNotFoundException;
import com.tour.exception.DeleteException;
import com.tour.exception.PrivacyRegistFailException;
import com.tour.model.domain.QnABoardPrivacyPass;
import com.tour.model.repository.QnABoardPrivacyPassDAO;

@Service
public class QnABoardPrivacyPassServiceImpl implements QnABoardPrivacyPassService {
	@Autowired
	private QnABoardPrivacyPassDAO privacyPassDAO;
	
	@Override
	public String select(int qnaBoard_id) throws DataNotFoundException{
		String pass = privacyPassDAO.select(qnaBoard_id);

		return pass;
	}

	@Override
	public int insert(QnABoardPrivacyPass qnaBoard_privacy_pass) throws PrivacyRegistFailException {
		int result = privacyPassDAO.insert(qnaBoard_privacy_pass);
		if(result == 0) {
			throw new PrivacyRegistFailException("비밀글 암호등록 실패!!");
		}
		return result;
	}

	@Override
	public int delete(int qnaBoard_id) throws DeleteException{
		int result = privacyPassDAO.delete(qnaBoard_id);
		if(result == 0) {
			throw new DeleteException("비밀글 암호 삭제 실패!");
		}
		return result;
	}

}

package com.tour.model.repository;

import com.tour.model.domain.QnABoardPrivacyPass;

public interface QnABoardPrivacyPassDAO {
	public String select(int qnaboard_id);
	public int insert(QnABoardPrivacyPass qnaBoard_privacy_pass);
	public int delete(int qnaBoard_id);
}

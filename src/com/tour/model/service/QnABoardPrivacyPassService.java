package com.tour.model.service;

import com.tour.model.domain.QnABoardPrivacyPass;

public interface QnABoardPrivacyPassService {
	public String select(int qnaBoard_id);
	public int insert(QnABoardPrivacyPass qnaBoard_privacy_pass);
	public int delete(int qnaBoard_id);
}

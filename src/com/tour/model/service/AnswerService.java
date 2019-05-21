package com.tour.model.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.tour.model.domain.Answer;

public interface AnswerService {
	public void insert(Answer answer);
	public void delete(Answer answer);
	public Answer select(int qnaBoard_id);
	public int update(Answer answer);
}

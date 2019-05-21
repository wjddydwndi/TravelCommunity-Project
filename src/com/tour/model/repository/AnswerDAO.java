package com.tour.model.repository;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.tour.model.domain.Answer;

public interface AnswerDAO {
	public int insert(Answer answer);
	public int delete(int answer_id);
	public int delete2(int qnaBoard_id);
	public Answer select(int answer_id);
	public int update(Answer answer);
}

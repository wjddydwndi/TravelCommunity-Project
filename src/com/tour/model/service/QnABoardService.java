package com.tour.model.service;

import java.util.List;

import com.tour.model.domain.QnABoard;

public interface QnABoardService {
	public List<QnABoard> selectAll();
	public int insert(QnABoard qnaBoard);
	public QnABoard select(int qnaBoard_id);
	public int delete(int qnaBoard_id);
	public int update(QnABoard qnaBoard);
	public int updateHit(int qnaBoard_id);
	public int updateAnswerState(QnABoard qnaBoard);
	public List<QnABoard> searchQnaBoards(int searchMode, String searchWord);
}

package com.tour.model.repository;

import java.util.List;

import com.tour.model.domain.QnABoard;

public interface QnABoardDAO {
	public List<QnABoard> selectAll();
	public int insert(QnABoard qnaBoard);
	public QnABoard select(int qnaBoard_id);
	public int delete(int qnaBoard_id);
	public int update(QnABoard qnaBoard);
	public int updateHit(int qnaBoard_id);
	public int updateAnswerState(QnABoard qnaBoard);
	public List<QnABoard> searchQnaBoards(int searchMode, String searchWord);
	public List<QnABoard> getMyQnaBoards(int member_id);
}

package com.tour.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tour.exception.DataNotFoundException;
import com.tour.exception.DeleteException;
import com.tour.exception.RegistException;
import com.tour.exception.UpdateException;
import com.tour.model.domain.QnABoard;
import com.tour.model.repository.AnswerDAO;
import com.tour.model.repository.QnABoardDAO;

@Service
public class QnABoardServiceImpl implements QnABoardService {
	@Autowired
	@Qualifier("mybatisQnABoardDAO")
	private QnABoardDAO boardDAO;
	
	@Autowired
	private AnswerDAO answerDAO;
	
	
	
	
	@Override
	public List<QnABoard> selectAll() throws DataNotFoundException{
		List<QnABoard> qnaBoardList = boardDAO.selectAll();
		if(qnaBoardList == null) {
			throw new DataNotFoundException("글 조회에 문제가 생겼습니다. 관리자에게 문의하세요.");
		}
		return qnaBoardList;
	}

	@Override
	public int insert(QnABoard qnaBoard) throws RegistException{
		int result=0;
		if(qnaBoard.getQnaBoard_content()!=null) {
			result = boardDAO.insert(qnaBoard);
		}
		if(result == 0) {
			throw new RegistException("게시글 내용이 없습니다!");
		}
		return result;
	}

	@Override
	public QnABoard select(int qnaBoard_id) throws DataNotFoundException{
		QnABoard qnaBoard = boardDAO.select(qnaBoard_id);
		if(qnaBoard == null) {
			throw new DataNotFoundException("게시글 조회 실패!, 관리자에게 문의하세요");
		}
		return qnaBoard;
	}

	
	@Transactional
	@Override
	public int delete(int qnaBoard_id) throws DeleteException{
		QnABoard qnaBoard = boardDAO.select(qnaBoard_id);
		int result = boardDAO.delete(qnaBoard_id);
		if(result == 0) {
			throw new DeleteException("게시글 삭제 실패, 관리자에게 문의하세요!");
		}
		if(qnaBoard.getQnaBoard_type_id().equals("2")) {
			if(qnaBoard.getAnswerState() != null) {
				int result2 = answerDAO.delete2(qnaBoard_id);
				if(result2==0) {
					throw new DeleteException("답변글 삭제 실패, 관리자에게 문의하세요!");
				}else {
					result=result2;
				}
			}
		}
		return result;
	}

	@Override
	public int update(QnABoard qnaBoard) throws UpdateException{
		int result = boardDAO.update(qnaBoard);
		if(result == 0) {
			throw new UpdateException("게시글 내용 수정 실패!!, 관리자에게 문의하세요!");
		}
		return result;
	}

	@Override
	public int updateHit(int qnaBoard_id) throws UpdateException{
		int result = boardDAO.updateHit(qnaBoard_id);
		//result = 0;
		if(result == 0) {
			throw new UpdateException("게시글 조회수 갱신 실패!!, 관리자에게 문의하세요!");
		}
		return result;
	}

	@Override
	public int updateAnswerState(QnABoard qnaBoard) throws UpdateException{
		int result = boardDAO.updateAnswerState(qnaBoard);
		//int result = 0;
		if(result == 0) {
			throw new UpdateException("게시글 답변 상태 갱신 실패!!, 관리자에게 문의하세요!");
		}
		return result;
	}
	
	// 고객센터 게시글 검색!!
	//=============================================================
	@Override
	public List<QnABoard> searchQnaBoards(int searchMode, String searchWord) {
		List<QnABoard> qnaBoardList = boardDAO.searchQnaBoards(searchMode, searchWord);
		return qnaBoardList;
	}
	//=============================================================

}

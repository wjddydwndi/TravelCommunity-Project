package com.tour.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.domain.QnABoard;

@Repository
public class MybatisQnABoardDAO implements QnABoardDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List<QnABoard> selectAll() {
		List<QnABoard> qnaBoardList = sqlSessionTemplate.selectList("QnABoard.selectAll");
		return qnaBoardList;
	}

	@Override
	public int insert(QnABoard qnaBoard) {
		int result = sqlSessionTemplate.insert("QnABoard.insert", qnaBoard);
		return result;
	}

	@Override
	public QnABoard select(int qnaBoard_id) {
		QnABoard board = sqlSessionTemplate.selectOne("QnABoard.select", qnaBoard_id);
		return board;
	}

	@Override
	public int delete(int qnaBoard_id) {
		int result = sqlSessionTemplate.delete("QnABoard.delete", qnaBoard_id);
		return result;
	}

	@Override
	public int update(QnABoard qnaBoard) {
		int result = sqlSessionTemplate.update("QnABoard.update", qnaBoard);
		return result;
	}

	@Override
	public int updateHit(int qnaBoard_id) {
		int result = sqlSessionTemplate.update("QnABoard.updateHit", qnaBoard_id);
		return result;
	}

	@Override
	public int updateAnswerState(QnABoard qnaBoard) {
		System.out.println("sqlSessionTemplate : "+sqlSessionTemplate);
		int result = sqlSessionTemplate.update("QnABoard.updateAnswerState", qnaBoard);
		return result;
	}
	//=============================================================
	
	
	
	
	// 게시글 검색
	//=============================================================
	@Override
	public List<QnABoard> searchQnaBoards(int searchMode, String searchWord) {
		System.out.println("MybatisQnABoardDAO : searchQnaBoards() 동작 : 검색 Mode : "+searchMode);
		System.out.println("MybatisQnABoardDAO : searchQnaBoards() 동작 : 검색어 : "+"%"+searchWord+"%");
		List<QnABoard> qnaBoardList = null;
		if(searchMode==0) {
			qnaBoardList = sqlSessionTemplate.selectList("QnABoard.searchTitle", "%"+searchWord+"%");
		}else {
			qnaBoardList = sqlSessionTemplate.selectList("QnABoard.searchTitleContent", "%"+searchWord+"%");
		}
		System.out.println("MybatisQnABoardDAO : DB 에서 찾은 검색어 해당 게시글 개수 : "+qnaBoardList.size());
	
		return qnaBoardList;
	}
	//=============================================================
	
	
	
	
	// 마이페이지 내가 쓴 게시글 조회
	//=============================================================
	@Override
	public List<QnABoard> getMyQnaBoards(int member_id) {
		List<QnABoard> qnaBoardList = sqlSessionTemplate.selectList("QnABoard.selectMyQnaBoards", member_id);
		System.out.println("마이페이지qnadao : 게시글 조회 갯수 : " + qnaBoardList.size());
		System.out.println("MybatisQnABoardDAO : getMyQnaBoards() : member_id : "+member_id);
		return qnaBoardList;
	}
	//=============================================================
}

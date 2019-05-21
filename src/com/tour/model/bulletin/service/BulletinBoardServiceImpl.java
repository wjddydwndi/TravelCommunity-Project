package com.tour.model.bulletin.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tour.exception.DeleteFailException;
import com.tour.exception.EditFailException;
import com.tour.exception.RegistFailException;
import com.tour.common.file.FileManager;
import com.tour.model.bulletin.domain.BulletinBoard;
import com.tour.model.bulletin.domain.BulletinComment;

import com.tour.model.bulletin.repository.BulletinBoardDAO;
import com.tour.model.bulletin.repository.BulletinCommentDAO;

@Service
public class BulletinBoardServiceImpl implements BulletinBoardService{
	@Autowired
	private FileManager fileManager;
	@Autowired
	@Qualifier("mybatisBulletinBoardDAO")
	private BulletinBoardDAO bulletinBoardDAO;
	

	@Autowired
	@Qualifier("mybatisBulletinCommentDAO")
	private BulletinCommentDAO bulletinCommentDAO;
	
	
	@Override
	public List selectAll() {
		List boardList=bulletinBoardDAO.selectAll();
		 
		return boardList;
	}
	//@Transactional(value = "transactionManager")
	@Override
	public BulletinBoard select(int bulletin_board_id) throws RegistFailException{
		BulletinBoard bulletinBoard=bulletinBoardDAO.select(bulletin_board_id);
		bulletinBoardDAO.updateHit(bulletin_board_id);
		return bulletinBoard;
	}
	
	
	//@Transactional(value = "transactionManager")
	@Override
	public void insert(BulletinBoard bulletinBoard) {
		int result=bulletinBoardDAO.insert(bulletinBoard);
		
		if(result==0) {
			throw new RegistFailException("자유게시판 글 등록에 실패했습니다");
		}

	}

	@Override
	public void update(BulletinBoard bulletinBoard) throws EditFailException{
		int result = bulletinBoardDAO.update(bulletinBoard);
		if(result==0) {
			throw new EditFailException("글 수정에 실패 했습니다");
		}
	}
	@Transactional(value = "transactionManager")
	@Override
	public void delete(int bulletin_board_id) throws DeleteFailException{
	
		int result =bulletinBoardDAO.delete(bulletin_board_id);
		List bulletinCommentList=bulletinCommentDAO.selectByBoard(bulletin_board_id);
		if(bulletinCommentList.size()!=0) {
			int result2 = bulletinCommentDAO.deleteByBoard(bulletin_board_id);
		}
		if(result ==0) {
			throw new DeleteFailException("글삭제에 실패 하였습니다");
		}
		/*
		 * if(result2 ==0) { throw new DeleteFailException("댓글 삭제에 실패 하였습니다"); }
		 */
	}
	
}

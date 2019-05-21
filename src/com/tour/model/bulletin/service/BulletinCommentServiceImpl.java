package com.tour.model.bulletin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.tour.exception.DeleteFailException;
import com.tour.exception.EditFailException;
import com.tour.exception.RegistFailException;
import com.tour.model.bulletin.domain.BulletinBoard;
import com.tour.model.bulletin.domain.BulletinComment;
import com.tour.model.bulletin.repository.BulletinCommentDAO;

@Service
public class BulletinCommentServiceImpl implements BulletinCommentService{
	@Autowired
	@Qualifier("mybatisBulletinCommentDAO")
	private BulletinCommentDAO bulletinCommentDAO;
	
	
	
	@Override
	public List selectAll() {
		
		return bulletinCommentDAO.selectAll();
	}
	
	
	
	@Override
	public BulletinComment select(int bulletin_comment_id) {
		BulletinComment bulletinComment = bulletinCommentDAO.select(bulletin_comment_id);
		return bulletinComment;
	}
	
	
	
	@Override
	public void insert(BulletinComment bulletinComment) {
		int result=bulletinCommentDAO.insert(bulletinComment);
		if(result==0) {
			throw new RegistFailException("댓글 등록에 실패했습니다");
		}
	}
	
	
	
	@Override
	public void update(BulletinComment bulletinComment) {
		int result = bulletinCommentDAO.update(bulletinComment);
		if(result==0) {
			throw new EditFailException("댓글 수정에 실패 했습니다");
		}
	}
	
	
	
	@Override
	public void delete(int bulletin_comment_id) {
		int result = bulletinCommentDAO.delete(bulletin_comment_id);
		if(result ==0) {
			throw new DeleteFailException("댓글삭제에 실패 하였습니다");
		}
		
	}
	
	
	
	@Override
	public List selectByBoard(int bulletin_board_id) {
		
		return bulletinCommentDAO.selectByBoard(bulletin_board_id);
	}
	

	
}

package com.tour.model.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.tour.exception.DeleteFailException;
import com.tour.exception.EditFailException;
import com.tour.exception.RegistFailException;
import com.tour.model.review.domain.Review_comment;
import com.tour.model.review.repository.Review_commentDAO;

@Service
public class Review_commentServiceImpl implements Review_commentService {

	@Autowired
	@Qualifier("mybatisReview_commentDAO")
	private Review_commentDAO review_commentDAO;
	
	@Override
	public List selectAll() {
		return null;
	}

	@Override
	public Review_comment select(int review_comment_id) {
		return review_commentDAO.select(review_comment_id);
	}

	@Override
	public void insert(Review_comment review_comment) throws RegistFailException {
		int result = review_commentDAO.insert(review_comment);
		if(result == 0) {
			throw new RegistFailException("댓글 등록 실패");
		}
	}

	@Override
	public void update(Review_comment review_comment) throws EditFailException{
		int result = review_commentDAO.update(review_comment);
		if(result == 0) {
			throw new EditFailException("댓글 수정 실패");
		}
	}

	@Override
	public void delete(int review_comment_id) throws DeleteFailException{
		int result = review_commentDAO.delete(review_comment_id);
		if(result == 0) {
			throw new DeleteFailException("댓글 삭제 실패");
		}
	}

	@Override
	public List selectByReviewId(int review_id) {
		return review_commentDAO.selectByReviewId(review_id);
	}

}

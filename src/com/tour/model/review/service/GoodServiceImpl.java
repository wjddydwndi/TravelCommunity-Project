package com.tour.model.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.tour.exception.DeleteFailException;
import com.tour.model.review.domain.Good;
import com.tour.model.review.repository.GoodDAO;

@Service
public class GoodServiceImpl implements GoodService {

	@Autowired
	@Qualifier("mybatisGoodDAO")
	private GoodDAO goodDAO;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Good select(int good_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Good good) {
		goodDAO.insert(good);
	}

	@Override
	public void delete(int good_id) throws DeleteFailException{
		int result = goodDAO.delete(good_id);
		if(result == 0) {
			throw new DeleteFailException("좋아요 삭제 실패");
		}
	}

	@Override
	public void update(Good good) {
		// TODO Auto-generated method stub

	}

	@Override
	public List selectByReviewId(int review_id) {
		// TODO Auto-generated method stub
		return goodDAO.selectByReviewId(review_id);
	}

}

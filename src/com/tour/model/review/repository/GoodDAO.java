package com.tour.model.review.repository;

import java.util.List;

import com.tour.model.review.domain.Good;

public interface GoodDAO {
	public List selectAll();
	public Good select(int good_id);
	public int delete(int good_id);
	public int update(Good good);
	public int insert(Good good);
	public List selectByReviewId(int review_id);
	public int deleteByReviewId(int review_id);
}

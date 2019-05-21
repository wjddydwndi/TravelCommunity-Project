package com.tour.model.review.service;

import java.util.List;

import com.tour.model.review.domain.Good;

public interface GoodService {
	public List selectAll();
	public Good select(int good_id);
	public void insert(Good good);
	public void delete(int good_id);
	public void update(Good good);
	public List selectByReviewId(int review_id);
}

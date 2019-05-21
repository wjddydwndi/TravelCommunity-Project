package com.tour.model.review.repository;

import java.util.List;

import com.tour.model.review.domain.Review;



public interface ReviewDAO {
	public List selectAll();
	public Review select(int review_id);
	public int insert(Review review);
	public int update(Review review);
	public int delete(int review_id);
	public int updateHit(int review_id);
	public List<Review> getMyReview(int member_id);
	public List selectByGood();
}

package com.tour.model.review.repository;

import java.util.List;

import com.tour.model.review.domain.Review_comment;

public interface Review_commentDAO {
	public List selectAll();
	public Review_comment select(int review_comment_id);
	public List selectByReviewId(int review_id);
	public int insert(Review_comment review_comment);
	public int update(Review_comment review_comment);
	public int delete(int review_comment_id);
	public int deleteByReviewId(int review_id);
}

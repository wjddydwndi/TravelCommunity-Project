package com.tour.model.review.service;

import java.util.List;

import com.tour.model.review.domain.Review_comment;

public interface Review_commentService {
	public List selectAll();
	public List selectByReviewId(int review_id);
	public Review_comment select(int review_comment_id);
	public void insert(Review_comment review_comment);
	public void update(Review_comment review_comment);
	public void delete(int review_comment_id);
}

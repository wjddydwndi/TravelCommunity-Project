package com.tour.model.review.repository;

import java.util.List;

import com.tour.model.review.domain.Path;

public interface PathDAO {
	public List selectAll();
	public int select(int path_id);
	public int insert(Path path);
	public int update(Path path);
	public int delete(int path_id);
	public int deleteByReviewId(int review_id);
}

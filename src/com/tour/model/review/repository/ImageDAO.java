package com.tour.model.review.repository;

import java.util.List;

import com.tour.model.review.domain.Image;

public interface ImageDAO {
	public List selectAll();
	public Image select(int image_id);
	public int delete(int image_id);
	public int update(Image image);
	public int insert(Image image);
	public int deleteByReviewId(int review_id);
	public int deleteFile(Image image);
}

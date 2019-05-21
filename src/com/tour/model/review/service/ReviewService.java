package com.tour.model.review.service;

import java.util.List;

import com.tour.model.review.domain.Image;
import com.tour.model.review.domain.Path;
import com.tour.model.review.domain.Review;

public interface ReviewService {
	public List selectAll();
	public Review select(int review_id);
	public void update(Review review, Image image, Path path,String filePath);
	public void delete(int review_id, String path);
	public void insert(Review review,Image image,Path path,String filePath);
	public void updateHit(int review_id);
	public List selectByGood();
}

package com.tour.model.review.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.gallery.domain.Gallery;
import com.tour.model.review.domain.Review;

@Repository
public class MybatisReviewDAO implements ReviewDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Review.selectAll");
	}

	@Override
	public Review select(int review_id) {
		return sqlSessionTemplate.selectOne("Review.select", review_id);
	}

	@Override
	public int insert(Review review) {
		return sqlSessionTemplate.insert("Review.insert", review);
	}

	@Override
	public int update(Review review) {
		return sqlSessionTemplate.update("Review.update", review);
	}

	@Override
	public int delete(int review_id) {
		return sqlSessionTemplate.delete("Review.delete", review_id);
	}

	@Override
	public int updateHit(int review_id) {
		return sqlSessionTemplate.update("Review.updateHit", review_id);
	}

	@Override
	public List<Review> getMyReview(int member_id) {
		List<Review> reviewList = sqlSessionTemplate.selectList("Review.selectMyReview", member_id);
		return reviewList;
	}

	@Override
	public List selectByGood() {
		List<Review> reviewList = sqlSessionTemplate.selectList("Review.selectByGood");
		/*
		 * System.out.println("); for(int i=0;
		 * i<reviewList.size(); i++) { Review review = reviewList.get(i);
		 * System.out.println(review.getReview_id());
		 * System.out.println(review.getImage().get(0).getFile_name());
		 * System.out.println(review.getReview_title()); }
		 */
		return reviewList;
	}
}

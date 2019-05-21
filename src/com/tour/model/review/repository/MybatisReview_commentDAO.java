package com.tour.model.review.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.review.domain.Review_comment;

@Repository
public class MybatisReview_commentDAO implements Review_commentDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public Review_comment select(int review_comment_id) {
		return sqlSessionTemplate.selectOne("Review_comment.select", review_comment_id);
	}

	@Override
	public int insert(Review_comment review_comment) {
		return sqlSessionTemplate.insert("Review_comment.insert", review_comment);
	}

	@Override
	public int update(Review_comment review_comment) {
		return sqlSessionTemplate.update("Review_comment.update", review_comment);
	}

	@Override
	public int delete(int review_comment_id) {
		return sqlSessionTemplate.delete("Review_comment.delete",review_comment_id);
	}

	@Override
	public List selectAll() {
		return null;
	}

	@Override
	public List selectByReviewId(int review_id) {
		return sqlSessionTemplate.selectList("Review_comment.selectByReviewId", review_id);
	}

	@Override
	public int deleteByReviewId(int review_id) {
		return sqlSessionTemplate.delete("Review_comment.deleteByReviewId", review_id);
	}

}

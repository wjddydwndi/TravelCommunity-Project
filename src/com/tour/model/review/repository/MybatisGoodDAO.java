package com.tour.model.review.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.review.domain.Good;

@Repository
public class MybatisGoodDAO implements GoodDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Good select(int good_id) {
		return sqlSessionTemplate.selectOne("Good.select", good_id);
	}

	@Override
	public int delete(int good_id) {
		return sqlSessionTemplate.delete("Good.delete", good_id);
	}

	@Override
	public int update(Good good) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(Good good) {
		return sqlSessionTemplate.insert("Good.insert", good);
	}

	@Override
	public List selectByReviewId(int review_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("Good.selectByReviewId", review_id);
	}

	@Override
	public int deleteByReviewId(int review_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.delete("Good.deleteByReviewId", review_id);
	}

}

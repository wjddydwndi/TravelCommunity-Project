package com.tour.model.review.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.review.domain.Path;

@Repository
public class MybatisPathDAO implements PathDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int select(int path_id) {
		return sqlSessionTemplate.selectOne("Path.select", path_id);
	}

	@Override
	public int insert(Path path) {
		return sqlSessionTemplate.insert("Path.insert", path);
	}

	@Override
	public int update(Path review) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(int path_id) {
		return sqlSessionTemplate.delete("Path.delete", path_id);
	}

	@Override
	public int deleteByReviewId(int review_id) {
		return sqlSessionTemplate.delete("Path.deleteByReviewId", review_id);
	}

}

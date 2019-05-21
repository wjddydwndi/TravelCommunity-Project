package com.tour.model.review.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.review.domain.Image;

@Repository
public class MybatisImageDAO implements ImageDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Image select(int image_id) {
		return sqlSessionTemplate.selectOne("Image.select", image_id);
	}

	@Override
	public int delete(int image_id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(Image image) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(Image image) {
		return sqlSessionTemplate.insert("Image.insert", image);
	}

	@Override
	public int deleteByReviewId(int review_id) {
		return sqlSessionTemplate.delete("Image.deleteByReviewId", review_id);
	}
	@Override
	public int deleteFile(Image image) { //update
		return sqlSessionTemplate.delete("Image.deleteFile", image);
	}
}

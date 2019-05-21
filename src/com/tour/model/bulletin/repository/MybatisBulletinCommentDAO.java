package com.tour.model.bulletin.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.bulletin.domain.BulletinComment;
@Repository
public class MybatisBulletinCommentDAO implements BulletinCommentDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Override
	public List selectAll() {
		
		return sqlSessionTemplate.selectList("BulletinComment.selectAll");
	}

	@Override
	public BulletinComment select(int bulletin_comment_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("BulletinComment",bulletin_comment_id);
	}

	@Override
	public int insert(BulletinComment bulletinComment) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.insert("BulletinComment.insert",bulletinComment);
	}

	@Override
	public int update(BulletinComment bulletinComment) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.update("BulletinComment.update",bulletinComment);
	}

	@Override
	public int delete(int bulletin_comment_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.delete("BulletinComment.delete", bulletin_comment_id);
	}

	@Override
	public int deleteByBoard(int bulletin_board_id) {
		
		return sqlSessionTemplate.delete("BulletinComment.deleteByBoard",bulletin_board_id);
	}

	@Override
	public List selectByBoard(int bulletin_board_id) {

		return sqlSessionTemplate.selectList("BulletinComment.selectByBoard",bulletin_board_id);
	}
	

}

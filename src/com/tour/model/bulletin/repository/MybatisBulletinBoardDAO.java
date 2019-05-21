package com.tour.model.bulletin.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.model.bulletin.domain.BulletinBoard;

@Repository 
public class MybatisBulletinBoardDAO implements BulletinBoardDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("BulletinBoard.selectAll");
	}

	@Override
	public BulletinBoard select(int bulletin_board_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectOne("BulletinBoard.select",bulletin_board_id);
	}

	@Override
	public int insert(BulletinBoard bulletinBoard) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.insert("BulletinBoard.insert", bulletinBoard);
	}

	@Override
	public int update(BulletinBoard bulletinBoard) {
		int result = sqlSessionTemplate.update("BulletinBoard.update",bulletinBoard);
		System.out.println(result);
		return result;
	}

	@Override
	public int delete(int bulletin_board_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.delete("BulletinBoard.delete",bulletin_board_id);
	}

	@Override
	public int updateHit(int bulletin_board_id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.update("BulletinBoard.updateHit", bulletin_board_id);
	}

	// 마이페이지 관련 내가 작성한 자유게시판 게시글 가져오기 (박현호 : 190503)
	//===============================================================================
	@Override
	public List<BulletinBoard> getMyBulletinBoards(int member_id) {
		List<BulletinBoard> bulletinBoardList = sqlSessionTemplate.selectList("BulletinBoard.selectMyBulletinBoards", member_id);
		return bulletinBoardList;
	}
	//===============================================================================
}

package com.tour.model.bulletin.repository;

import java.util.List;

import com.tour.model.bulletin.domain.BulletinBoard;
import com.tour.model.domain.QnABoard;



public interface BulletinBoardDAO {
	public List selectAll();
	public BulletinBoard select(int bulletin_board_id);
	public int insert(BulletinBoard bulletinBoard);
	public int update(BulletinBoard bulletinBoard);
	public int delete(int bulletin_board_id);
	public int updateHit(int bulletin_board_id);
	public List<BulletinBoard> getMyBulletinBoards(int member_id);
	
}

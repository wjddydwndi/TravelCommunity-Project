package com.tour.model.bulletin.repository;

import java.util.List;

import com.tour.model.bulletin.domain.BulletinBoard;
import com.tour.model.bulletin.domain.BulletinComment;

public interface BulletinCommentDAO {
	public List selectAll();
	public BulletinComment select(int bulletin_comment_id);
	public int insert(BulletinComment bulletinComment);
	public int update(BulletinComment bulletinComment);
	public int delete(int bulletin_comment_id);
	public int deleteByBoard(int bulletin_board_id);
	public List selectByBoard(int bulletin_board_id);
}

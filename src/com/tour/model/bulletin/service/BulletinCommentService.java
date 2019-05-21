package com.tour.model.bulletin.service;

import java.util.List;

import com.tour.model.bulletin.domain.BulletinComment;

public interface BulletinCommentService {
	public List selectAll();
	public BulletinComment select(int bulletin_comment_id);
	public void insert(BulletinComment bulletinComment);
	public void update(BulletinComment bulletinComment);
	public void delete(int bulletin_comment_id);
	public List selectByBoard(int bulletin_board_id);
}

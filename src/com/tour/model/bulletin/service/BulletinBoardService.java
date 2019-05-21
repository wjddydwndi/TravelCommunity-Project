package com.tour.model.bulletin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.tour.model.bulletin.domain.BulletinBoard;


public interface BulletinBoardService {
	public List selectAll();
	public BulletinBoard select(int bulletin_board_id);
	public void insert(BulletinBoard bulletinBoard);
	public void update(BulletinBoard bulletinBoard);
	public void delete(int bulletin_board_id);
	
}

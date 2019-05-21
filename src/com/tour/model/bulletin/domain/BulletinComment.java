package com.tour.model.bulletin.domain;

/**
 * @author user
 *
 */
public class BulletinComment {
	private int bulletin_comment_id;
	private BulletinMember member;
	
	private String content;
	private String regdate;
	private BulletinBoard bulletinBoard;
	private int depth;
	private int rank;
	public int getBulletin_comment_id() {
		return bulletin_comment_id;
	}
	public void setBulletin_comment_id(int bulletin_comment_id) {
		this.bulletin_comment_id = bulletin_comment_id;
	}
	public BulletinMember getMember() {
		return member;
	}
	public void setMember(BulletinMember member) {
		this.member = member;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public BulletinBoard getBulletinBoard() {
		return bulletinBoard;
	}
	public void setBulletinBoard(BulletinBoard bulletinBoard) {
		this.bulletinBoard = bulletinBoard;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}

	
}

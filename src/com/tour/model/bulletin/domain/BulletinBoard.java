package com.tour.model.bulletin.domain;

import java.util.List;

public class BulletinBoard {
	private int bulletin_board_id;
	private Head head;
	private BulletinMember member;
	private String bulletin_title;
	private String bulletin_content;
	private String bulletin_regdate;
	private int bulletin_hit;

	public int getBulletin_board_id() {
		return bulletin_board_id;
	}
	public void setBulletin_board_id(int bulletin_board_id) {
		this.bulletin_board_id = bulletin_board_id;
	}
	public Head getHead() {
		return head;
	}
	public void setHead(Head head) {
		this.head = head;
	}
	
	public BulletinMember getMember() {
		return member;
	}
	public void setMember(BulletinMember member) {
		this.member = member;
	}
	public String getBulletin_title() {
		return bulletin_title;
	}
	public void setBulletin_title(String bulletin_title) {
		this.bulletin_title = bulletin_title;
	}
	public String getBulletin_content() {
		return bulletin_content;
	}
	public void setBulletin_content(String bulletin_content) {
		this.bulletin_content = bulletin_content;
	}
	public String getBulletin_regdate() {
		return bulletin_regdate;
	}
	public void setBulletin_regdate(String bulletin_regdate) {
		this.bulletin_regdate = bulletin_regdate;
	}
	public int getBulletin_hit() {
		return bulletin_hit;
	}
	public void setBulletin_hit(int bulletin_hit) {
		this.bulletin_hit = bulletin_hit;
	}

	
	
}

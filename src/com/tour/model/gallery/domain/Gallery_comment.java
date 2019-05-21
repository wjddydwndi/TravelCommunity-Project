package com.tour.model.gallery.domain;

import com.tour.model.bulletin.domain.BulletinMember;

public class Gallery_comment {
	private int comment_id;
	private Gallery gallery;
	private BulletinMember member;
	private String content;
	private String regdate;
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public Gallery getGallery() {
		return gallery;
	}
	public void setGallery(Gallery gallery) {
		this.gallery = gallery;
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

	
}

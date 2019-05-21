package com.tour.model.review.domain;

import java.util.List;

import com.tour.model.bulletin.domain.BulletinMember;

public class Review {
	private int review_id; // pk
	private BulletinMember member; // ass
	private String review_title;
	private String review_content;
	private String review_regdate;
	private int review_hit;
	private int review_good;
	private List<Image> image; //게시판에서 이미지를 참조하는 방법 + 연결고리(이미지쪽의 내용을 여기다가 담음)
	private List<Path> paths;	
	
	
	public List<Path> getPaths() {
		return paths;
	}

	public void setPaths(List<Path> paths) {
		this.paths = paths;
	}

	public List<Image> getImage() {
		return image;
	}

	public void setImage(List<Image> image) {
		this.image = image;
	}

	public int getReview_id() {
		return review_id;
	}

	public void setReview_id(int review_id) {
		this.review_id = review_id;
	}

	public BulletinMember getMember() {
		return member;
	}

	public void setMember(BulletinMember member) {
		this.member = member;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public String getReview_regdate() {
		return review_regdate;
	}

	public void setReview_regdate(String review_regdate) {
		this.review_regdate = review_regdate;
	}

	public int getReview_hit() {
		return review_hit;
	}

	public void setReview_hit(int review_hit) {
		this.review_hit = review_hit;
	}

	public int getReview_good() {
		return review_good;
	}

	public void setReview_good(int review_good) {
		this.review_good = review_good;
	}

}

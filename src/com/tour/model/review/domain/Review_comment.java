package com.tour.model.review.domain;

import com.tour.model.bulletin.domain.BulletinMember;

public class Review_comment {
	private int review_comment_id; // pk
	private BulletinMember member; // ass
	private String review_comment_content;
	private Review review; // ass
	private String review_comment_regdate;

	public int getReview_comment_id() {
		return review_comment_id;
	}

	public void setReview_comment_id(int review_comment_id) {
		this.review_comment_id = review_comment_id;
	}

	public BulletinMember getMember() {
		return member;
	}

	public void setMember(BulletinMember member) {
		this.member = member;
	}

	public String getReview_comment_content() {
		return review_comment_content;
	}

	public void setReview_comment_content(String review_comment_content) {
		this.review_comment_content = review_comment_content;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public String getReview_comment_regdate() {
		return review_comment_regdate;
	}

	public void setReview_comment_regdate(String review_comment_regdate) {
		this.review_comment_regdate = review_comment_regdate;
	}

}

package com.tour.model.review.domain;

import com.tour.model.bulletin.domain.BulletinMember;

public class Good {
	private int good_id; // pk
	private BulletinMember member; // ass
	private Review review; // ass

	public int getGood_id() {
		return good_id;
	}

	public void setGood_id(int good_id) {
		this.good_id = good_id;
	}

	public BulletinMember getMember() {
		return member;
	}

	public void setMember(BulletinMember member) {
		this.member = member;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

}

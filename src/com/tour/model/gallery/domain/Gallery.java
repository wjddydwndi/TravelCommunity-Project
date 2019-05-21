package com.tour.model.gallery.domain;

import java.util.List;

import com.tour.model.bulletin.domain.BulletinMember;

public class Gallery {
	private int gallery_id;
	private BulletinMember member;
	private String gallery_title;
	private String gallery_content;
	private String gallery_regdate;
	private int gallery_hit;
	private List<Gallery_image> gallery_images;
	
	public int getGallery_id() {
		return gallery_id;
	}
	public void setGallery_id(int gallery_id) {
		this.gallery_id = gallery_id;
	}
	public BulletinMember getMember() {
		return member;
	}
	public void setMember(BulletinMember member) {
		this.member = member;
	}
	public String getGallery_title() {
		return gallery_title;
	}
	public void setGallery_title(String gallery_title) {
		this.gallery_title = gallery_title;
	}
	public String getGallery_content() {
		return gallery_content;
	}
	public void setGallery_content(String gallery_content) {
		this.gallery_content = gallery_content;
	}
	public String getGallery_regdate() {
		return gallery_regdate;
	}
	public void setGallery_regdate(String gallery_regdate) {
		this.gallery_regdate = gallery_regdate;
	}
	public int getGallery_hit() {
		return gallery_hit;
	}
	public void setGallery_hit(int gallery_hit) {
		this.gallery_hit = gallery_hit;
	}
	public List<Gallery_image> getGallery_images() {
		return gallery_images;
	}
	public void setGallery_images(List<Gallery_image> gallery_images) {
		this.gallery_images = gallery_images;
	}
	
}

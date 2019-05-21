package com.tour.model.gallery.domain;

import org.springframework.web.multipart.MultipartFile;

public class Gallery_image {
	private int gallery_image_id;
	private Gallery gallery;
	private String filename;
	private MultipartFile[] myFile;
	///////////////////////////////////
	private String[] deleteFile;
	//////////////////////////////////////
	
	
	public int getGallery_image_id() {
		return gallery_image_id;
	}
	public void setGallery_image_id(int gallery_image_id) {
		this.gallery_image_id = gallery_image_id;
	}
	public Gallery getGallery() {
		return gallery;
	}
	public void setGallery(Gallery gallery) {
		this.gallery = gallery;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public MultipartFile[] getMyFile() {
		return myFile;
	}
	public void setMyFile(MultipartFile[] myFile) {
		this.myFile = myFile;
	}
	
	public String[] getDeleteFile() {
		return deleteFile;
	}
	public void setDeleteFile(String[] deleteFile) {
		this.deleteFile = deleteFile;
	}
	


	
}

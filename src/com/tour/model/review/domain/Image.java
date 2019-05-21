package com.tour.model.review.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Image {
	private int image_id; // pk
	private String file_name;
	private Review review; // ass
	private List<MultipartFile> myfile; // 스프링에서 파일을 제어할 수 있는 파일 처리자를 등록
	private List<String> deleteFile;

	public int getImage_id() {
		return image_id;
	}

	public void setImage_id(int image_id) {
		this.image_id = image_id;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public List<MultipartFile> getMyfile() {
		return myfile;
	}

	public void setMyfile(List<MultipartFile> myfile) {
		this.myfile = myfile;
	}

	public List<String> getDeleteFile() {
		return deleteFile;
	}

	public void setDeleteFile(List<String> deleteFile) {
		this.deleteFile = deleteFile;
	}

}

package com.tour.model.review.domain;
import java.util.List;

public class Path {
	private int path_id; // pk
	private double lati;
	private double longi;
	private Review review; // ass
	private String path_name;
	private String selectedPath; // user가 선택한 경로

	public int getPath_id() {
		return path_id;
	}

	public void setPath_id(int path_id) {
		this.path_id = path_id;
	}

	public double getLati() {
		return lati;
	}

	public void setLati(double lati) {
		this.lati = lati;
	}

	public double getLongi() {
		return longi;
	}

	public void setLongi(double longi) {
		this.longi = longi;
	}

	public Review getReview() {
		return review;
	}

	public void setReview(Review review) {
		this.review = review;
	}

	public String getPath_name() {
		return path_name;
	}

	public void setPath_name(String path_name) {
		this.path_name = path_name;
	}

	public String getSelectedPath() {
		return selectedPath;
	}

	public void setSelectedPath(String selectedPath) {
		this.selectedPath = selectedPath;
	}

}

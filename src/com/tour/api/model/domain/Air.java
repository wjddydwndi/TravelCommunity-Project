package com.tour.api.model.domain;

public class Air {
	private int air_id;
	private String dataTime;
	private String subArea;
	private int fine;
	private int ultrafine;
	public int getAir_id() {
		return air_id;
	}
	public void setAir_id(int air_id) {
		this.air_id = air_id;
	}
	public String getDataTime() {
		return dataTime;
	}
	public void setDataTime(String dataTime) {
		this.dataTime = dataTime;
	}
	public String getSubArea() {
		return subArea;
	}
	public void setSubArea(String subArea) {
		this.subArea = subArea;
	}
	public int getFine() {
		return fine;
	}
	public void setFine(int fine) {
		this.fine = fine;
	}
	public int getUltrafine() {
		return ultrafine;
	}
	public void setUltrafine(int ultrafine) {
		this.ultrafine = ultrafine;
	}
	
}

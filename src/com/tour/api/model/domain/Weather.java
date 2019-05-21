package com.tour.api.model.domain;

public class Weather {
	private int weather_id;
	private String city;
	private int xpoint;
	private int ypoint;
	private String category;
	private int baseDate;
	private int baseTime;
	private int fcstDate;
	private String fcstValue;
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getWeather_id() {
		return weather_id;
	}
	public void setWeather_id(int weather_id) {
		this.weather_id = weather_id;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public int getXpoint() {
		return xpoint;
	}
	public void setXpoint(int xpoint) {
		this.xpoint = xpoint;
	}
	public int getYpoint() {
		return ypoint;
	}
	public void setYpoint(int ypoint) {
		this.ypoint = ypoint;
	}

	public int getBaseDate() {
		return baseDate;
	}
	public void setBaseDate(int baseDate) {
		this.baseDate = baseDate;
	}
	public int getBaseTime() {
		return baseTime;
	}
	public void setBaseTime(int baseTime) {
		this.baseTime = baseTime;
	}
	public int getFcstDate() {
		return fcstDate;
	}
	public void setFcstDate(int fcstDate) {
		this.fcstDate = fcstDate;
	}
	public String getFcstValue() {
		return fcstValue;
	}
	public void setFcstValue(String fcstValue) {
		this.fcstValue = fcstValue;
	}

	
	
}

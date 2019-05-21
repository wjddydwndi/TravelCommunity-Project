package com.tour.api.model.service;

import java.util.List;

import com.tour.api.model.domain.Weather;

public interface WeatherService {
	public Weather selectByCityName(String city);
	public List getWeather(String city);
	public List selectAll();
}

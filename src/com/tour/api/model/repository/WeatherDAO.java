package com.tour.api.model.repository;

import java.util.List;

import com.tour.api.model.domain.Weather;

public interface WeatherDAO {
	public Weather selectByCityName(String city);
	public List selectAll();
}

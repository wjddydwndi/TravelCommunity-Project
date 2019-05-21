package com.tour.api.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.tour.api.WeatherParser;
import com.tour.api.model.domain.Weather;
import com.tour.api.model.repository.WeatherDAO;
@Service
public class WeatherServiceImpl implements WeatherService{
	@Autowired
	@Qualifier("mybatisWeatherDAO")
	private WeatherDAO weatherDAO;
	
	private WeatherParser weatherParser;
	@Override
	public Weather selectByCityName(String city) {
		return weatherDAO.selectByCityName(city);
	}

	public List getWeather(String city) {
		System.out.println("WeatherServiceImpl : getWeather() : city : "+city);
		Weather weather=weatherDAO.selectByCityName(city);
		System.out.println("WeatherServiceImpl : getWeather() : weather : "+weather);
		System.out.println(weather.getXpoint());
		System.out.println(weather.getYpoint());
		weatherParser = new WeatherParser();
		// API 에서 끌어오는 지역 날씨정보 관련 Code
		//=====================================================
		List list=weatherParser.getWeather(weather.getXpoint(), weather.getYpoint());
		//=====================================================
		
		return list;
	}

	@Override
	public List selectAll() {
		return weatherDAO.selectAll();
	}

}

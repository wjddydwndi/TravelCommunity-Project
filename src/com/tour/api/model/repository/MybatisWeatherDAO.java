package com.tour.api.model.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tour.api.model.domain.Weather;
@Repository
public class MybatisWeatherDAO implements WeatherDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public Weather selectByCityName(String city) {
		System.out.println("MybatisWeatherDAO : selectByCityName() : city : "+city);
		Weather weather = sqlSessionTemplate.selectOne("Weather.selectByCityName", city);
		System.out.println("MybatisWeatherDAO : selectByCityName() : weather : "+weather);
		
		return weather;
	}
	
	@Override
	public List selectAll() {
		
		return sqlSessionTemplate.selectList("Weather.selectAll");
	}
	
}

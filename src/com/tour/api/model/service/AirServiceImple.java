package com.tour.api.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.tour.api.AirParser;

@Service
public class AirServiceImple implements AirService{
	
	private AirParser airParser;
	@Override
	public String[] getArea() {
		String[] area  = {"서울", "부산", "대구", "인천", "광주", "대전", "울산", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주", "세종"};
		return area;
	}

	@Override
	public List getAirCondition(String area) {
		airParser = new AirParser();
		List list=airParser.getAirCondition(area);
		return list;
	}
	
}

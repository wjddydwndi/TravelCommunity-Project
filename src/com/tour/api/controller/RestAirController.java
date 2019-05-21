package com.tour.api.controller;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tour.api.model.domain.Weather;
import com.tour.api.model.service.AirService;
import com.tour.api.model.service.WeatherService;
import com.tour.api.model.service.WeatherServiceImpl;



@RestController
public class RestAirController {
	@Autowired
	private AirService airService;
	@Autowired
	private WeatherService weatherService;
	@RequestMapping(value = "/areas",method =RequestMethod.GET)
	public String[] getAirApiArea() {
		String[] area=airService.getArea();
		return area;
	}
	@RequestMapping(value = "/airs",method = RequestMethod.GET)
	public List getAirCondition(@RequestParam("area") String area) {
		System.out.println(area);
		List list=airService.getAirCondition(area);
		return list;
	}
	@RequestMapping(value ="/weathers",method = RequestMethod.GET)
	public List getWeather(@RequestParam("city") String city) {
		System.out.println("RestAirController : getWeather() : city : "+city);
		List weatherList=weatherService.getWeather(city);
		return weatherList;//weatherList;
	}
	@RequestMapping(value ="/cities",method = RequestMethod.GET)
	public List selectAll() {
		return weatherService.selectAll();
	}
}
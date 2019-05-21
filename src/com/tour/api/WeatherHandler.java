package com.tour.api;

import java.util.ArrayList;
import java.util.List;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import com.tour.api.model.domain.Weather;

public class WeatherHandler extends DefaultHandler{
	Weather weather;
	private boolean item;
	private boolean category;
	private boolean baseDate;
	private boolean baseTime;
	private boolean fcstDate;
	private boolean fcstValue;
	List<Weather> weatherList;
	
	public List<Weather> getWeatherList() {
		return weatherList;
	}
	@Override
	public void startDocument() throws SAXException {
	
		weatherList = new ArrayList<Weather>();
		
	}
	@Override
	public void startElement(String uri, String localName, String tag, Attributes attributes) throws SAXException {
		if(tag.equals("item")) {
			weather = new Weather();
			item = true;
		}
		if(tag.equals("category")) {
			category = true;
		}
		if(tag.equals("baseDate")) {
			baseDate = true;
		}
		if(tag.equals("baseTime")) {
			baseTime = true;
		}
		if(tag.equals("fcstDate")) {
			fcstDate = true;
		}
		if(tag.equals("fcstValue")) {
			fcstValue = true;
		}
	}
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		String content = new String(ch,start,length);
		if(category) {
			weather.setCategory(content);
		}
		if(baseDate) {
			weather.setBaseDate(Integer.parseInt(content));
		}
		if(fcstDate) {
			weather.setFcstDate(Integer.parseInt(content));
		}
		if(fcstValue) {
			weather.setFcstValue(content);
		}
	}
	@Override
	public void endElement(String uri, String localName, String tag) throws SAXException {
		if(tag.equals("item")) {
			weatherList.add(weather);
			item = false;
		}
		if(tag.equals("category")) {
			category = false;
		}
		if(tag.equals("baseDate")) {
			baseDate = false;
		}
		if(tag.equals("baseTime")) {
			baseTime = false;
		}
		if(tag.equals("fcstDate")) {
			fcstDate = false;
		}
		if(tag.equals("fcstValue")) {
			fcstValue = false;
		}
	}
	@Override
	public void endDocument() throws SAXException {

		//System.out.println(weatherList.size());
		
	}
}

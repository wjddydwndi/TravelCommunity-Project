package com.tour.api;

import java.util.ArrayList;
import java.util.List;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import com.tour.api.model.domain.Air;

public class AirHandler extends DefaultHandler{
	Air air;
	private boolean item;
	private boolean dataTime;
	private boolean subArea;
	private boolean fine;
	private boolean ultrafine;
	
	private List<Air> airList;
	
	public List<Air> getAirList() {
		return airList;
	}
	
	
	@Override
	public void startDocument() throws SAXException {
		airList = new ArrayList<Air>();
	}
	@Override
	public void startElement(String uri, String localName, String tag, Attributes attributes) throws SAXException {
		if(tag.equals("item")) {
			air = new Air();
			item = true;
		}	
		if(tag.equals("dataTime")) {
			dataTime = true;
		}
		if(tag.equals("cityName")) {
			subArea =true;
		}
		if(tag.equals("pm10Value")) {
			fine = true;
		}
		if(tag.equals("pm25Value")) {
			ultrafine = true;
		}
	}
	@Override
	public void characters(char[] ch, int start, int length) throws SAXException {
		String content = new String(ch, start, length);
		if(dataTime) {
			air.setDataTime(content);
		}
		if(subArea) {
			air.setSubArea(content);
		}
		if(fine) {
			if(content.contains("-")) {
				air.setFine(0);
			}else {
				air.setFine(Integer.parseInt(content));
			}
		}
		if(ultrafine) {
			if(content.contains("-")) {
				air.setUltrafine(0);
			}else {
				air.setUltrafine(Integer.parseInt(content));
			}
		}

	}
	@Override
	public void endElement(String uri, String localName, String tag) throws SAXException {
		if(tag.equals("item")) {
			airList.add(air);
			item = false;
		}	
		if(tag.equals("dataTime")) {
			dataTime = false;
		}
		if(tag.equals("cityName")) {
			subArea =false;
		}
		if(tag.equals("pm10Value")) {
			fine = false;
		}
		if(tag.equals("pm25Value")) {
			ultrafine = false;
		}
	}

}

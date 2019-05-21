package com.tour.api;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.SAXException;

import com.tour.common.board.CurrentDay;

public class WeatherParser {
	SAXParserFactory saxParserFactory;
	SAXParser saxParser;//파싱을 담당하는 객체
	URL url;
	URLConnection con;
	WeatherHandler weatherHandler;
	StringBuilder urlBuilder=null;
	List weatherList=null;
	public WeatherParser() {
		saxParserFactory = SAXParserFactory.newInstance();
	}
	public List getWeather(int xpoint,int ypoint) {
        try {
        	String currentDay=CurrentDay.getCurrentDate();
        	//0200, 0500, 0800, 1100, 1400, 1700, 2000, 2300;
        	String currentTime=CurrentDay.getCurrnetTime();
        	int time=Integer.parseInt(currentTime);
        	System.out.println(currentTime);
        	System.out.println(time);
        	if(time>300 && time<=600) {
        		currentTime = "0"+"200";
        	}else if(time>600 && time<=900) {
        		currentTime = "0"+"500";
        	}else if(time>900 && time<=1200) {
        		currentTime = "0"+"800";
        	}else if(time>1200 && time<=1500) {
        		currentTime = "1100";
        	}else if(time>1500 && time<=1800) {
        		currentTime = "1400";
        	}else if(time>1800 && time<=2100) {
        		currentTime = "1700";
        	}else if(time>2100 && time<=2359) {
        		currentTime = "2000";
        	}else if(time>0000 && time<=200) {
        		currentTime = "2300";
        		int a=Integer.parseUnsignedInt(currentDay);
        		a =a-1;
        		currentDay = Integer.toString(a);
        	}
			urlBuilder = new StringBuilder("http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData"); /*URL*/
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=aomUsxnLb3DTqHQIrlwe9AM5XaeflDF4oLW73sSIeo5EC6EEu6GUKunzwiTqsDuMycHJHeU4Y0weHHkYR%2BvUlw%3D%3D"); /*Service Key*/
			urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("aomUsxnLb3DTqHQIrlwe9AM5XaeflDF4oLW73sSIeo5EC6EEu6GUKunzwiTqsDuMycHJHeU4Y0weHHkYR%2BvUlw%3D%3D", "UTF-8")); /*서비스 인증*/
			urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(currentDay, "UTF-8")); /*‘15년 12월 1일발표*/
			urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(currentTime, "UTF-8")); /*05시 발표 * 기술문서 참조*/
			urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(Integer.toString(xpoint), "UTF-8")); /*예보지점의 X 좌표값*/
			urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(Integer.toString(ypoint), "UTF-8")); /*예보지점의 Y 좌표값*/
			urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*한 페이지 결과 수*/
			urlBuilder.append("&" + URLEncoder.encode("ftype","UTF-8") + "=" + URLEncoder.encode("ODAM", "UTF-8")); /*파일구분 -ODAM: 동네예보실황 -VSRT: 동네예보초단기 -SHRT: 동네예보단기*/
			urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
			urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*xml(기본값), json*/
			url = new URL(urlBuilder.toString());
			con=url.openConnection();
			saxParser = saxParserFactory.newSAXParser();
			saxParser.parse(con.getInputStream(),weatherHandler=new WeatherHandler());
			weatherList= weatherHandler.getWeatherList();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return weatherList;
	}
}

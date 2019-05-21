package com.tour.api;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.SAXException;





public class AirParser {
	SAXParserFactory saxParserFactory;
	SAXParser saxParser;//파싱을 담당하는 객체
	URL url;
	URLConnection con;
	AirHandler airHandler;
	StringBuilder urlBuilder=null;
	List airList=null;
	public AirParser() {
		saxParserFactory = SAXParserFactory.newInstance();
	}
	public List getAirCondition(String area) {
		 	try {
				urlBuilder = new StringBuilder("http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureSidoLIst"); /*URL*/
				urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=aomUsxnLb3DTqHQIrlwe9AM5XaeflDF4oLW73sSIeo5EC6EEu6GUKunzwiTqsDuMycHJHeU4Y0weHHkYR%2BvUlw%3D%3D"); /*Service Key*/
				if(area.equals("서울")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("26", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("부산")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("16", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("대구")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("8", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("인천")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("9", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("광주")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("6", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("대전")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("6", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("울산")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("5", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("경기")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("31", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("강원")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("18", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("충북")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("11", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("충남")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("15", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("전북")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("14", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("전남")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("18", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("경북")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("12", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("경남")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("14", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("제주")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("2", "UTF-8")); /*한 페이지 결과 수*/
				}
				if(area.equals("세종")) {
					urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*한 페이지 결과 수*/
				}
				urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
				urlBuilder.append("&" + URLEncoder.encode("sidoName","UTF-8") + "=" + URLEncoder.encode(area, "UTF-8")); /*시도 이름 (서울, 부산, 대구, 인천, 광주, 대전, 울산, 경기, 강원, 충북, 충남, 전북, 전남, 경북, 경남, 제주, 세종)*/
				urlBuilder.append("&" + URLEncoder.encode("searchCondition","UTF-8") + "=" + URLEncoder.encode("DAILY", "UTF-8")); /*요청 데이터기간 (시간 : HOUR, 하루 : DAILY)*/
				url = new URL(urlBuilder.toString());
				con=url.openConnection();
				saxParser = saxParserFactory.newSAXParser();
				saxParser.parse(con.getInputStream(),airHandler=new AirHandler());
				airList= airHandler.getAirList();
		 	} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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
		
		return airList;
	}
}

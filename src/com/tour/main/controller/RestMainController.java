package com.tour.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.tour.model.gallery.service.GalleryService;

@RestController
public class RestMainController {
	@Autowired
	GalleryService galleryService;
	

	@RequestMapping(value="/main/list",method=RequestMethod.GET)
	
	public List getList() {
		System.out.println("MainController /getList");
		List galleryList = galleryService.mainSelectAll();
		System.out.println("MainController /getList / DBÅë°ú"+galleryList.size());
		
		
		return galleryList;
	}
	
	

}

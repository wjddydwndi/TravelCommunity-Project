package com.tour.gallery.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tour.common.board.ReviewPager;
import com.tour.exception.DeleteFailException;
import com.tour.exception.RegistFailException;
import com.tour.exception.SelectFailException;
import com.tour.exception.UpdateFailException;
import com.tour.model.bulletin.domain.BulletinMember;
import com.tour.model.bulletin.service.BulletinMemberService;
import com.tour.model.gallery.domain.Gallery;
import com.tour.model.gallery.domain.Gallery_image;
import com.tour.model.gallery.service.GalleryService;

@Controller
public class GalleryController {
	@Autowired
	private GalleryService galleryService;
	
	@Autowired
	private BulletinMemberService bulletinMemberService;
	
	
	private ReviewPager pager = new ReviewPager();

	@RequestMapping(value = "/gallerys", method = RequestMethod.POST)
	public String insert(Gallery gallery, Gallery_image gallery_image, HttpServletRequest request) {
		System.out.println("/Controller / insert / gallery =="+gallery);
		System.out.println("/Controller / insert / gallery_image =="+gallery_image);

		// Mapper에서 resultMap이용해서 수정할 것.
		BulletinMember member = (BulletinMember) request.getSession().getAttribute("member");
		gallery.setMember(member);
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		String path = request.getServletContext().getRealPath("/chimper/chimper/uploadFile");
		galleryService.insert(gallery, gallery_image, path);
		return "redirect:/gallerys";
	}

	// 전체목록 불러오기
	@RequestMapping(value = "/gallerys", method = RequestMethod.GET)
	public ModelAndView selectAll(HttpServletRequest request) {
		System.out.println("Controller/ selectAll");
		
		List<Gallery> galleryList = galleryService.selectAll();
		pager.init(request, galleryList,15,10);

		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("chimper/chimper/gallery/index");
		mav.addObject("pager", pager);
		mav.addObject("galleryList", galleryList);

		System.out.println("mav 통과");
		return mav;
	}

	// 게시글 삭제
	@RequestMapping(value = "/gallerys/delete/{gallery_id}", method = RequestMethod.GET)

	public String delete(@PathVariable("gallery_id") int gallery_id, HttpServletRequest request) {
		System.out.println("Controller/ delete /gallery_id=" + gallery_id);

		String path = request.getServletContext().getRealPath("/chimper/chimper/uploadFile");
		galleryService.delete(gallery_id, path);
		return "redirect:/gallerys";
	}

	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 한건의 데이터를 가져온다.
	// 댓글, 이미지 포함.
	@RequestMapping(value = "/gallerys/{gallery_id}", method = RequestMethod.GET)
	public ModelAndView getDetail(@PathVariable("gallery_id") int gallery_id, HttpServletRequest request) {
		System.out.println("Controller/getDetail /gallery_id==" +gallery_id);
		
		String path = null;
		Gallery gallery = (Gallery) galleryService.select(gallery_id);
		BulletinMember member = (BulletinMember) request.getSession().getAttribute("member");

		galleryService.updateHit(gallery_id);
		ModelAndView mav = new ModelAndView();
		
	
			mav.addObject("gallery", gallery);
		
			
			if(member!=null) {
				if (gallery.getMember().getMember_id() == member.getMember_id()) {
					path = "chimper/chimper/gallery/edit";
				} else {
					path = "chimper/chimper/gallery/detail";
				}
			}else {
				path = "redirect:/chimper/chimper/index.jsp";
			}

		

		mav.setViewName(path);
		return mav;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	@RequestMapping(value = "/gallerys/edit", method = RequestMethod.POST)
	public String update(Gallery gallery, Gallery_image gallery_image, HttpServletRequest request) {
		System.out.println("Controller/update /gallery==" +gallery);
		System.out.println("Controller/update /gallery_image ==" + gallery_image);
		
		String path = request.getServletContext().getRealPath("/chimper/chimper/uploadFile");
		
		galleryService.update(gallery, gallery_image, path);
		System.out.println("Controller/update/ Service 통과 ");
		return "redirect:/gallerys";
	}

	///////////////////// 검색/////////////////////////
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public ModelAndView searchGallery(HttpServletRequest request,String searchType, String searchText) {
		System.out.println("Controller/searchGallery /searchType==" + searchType);
		System.out.println("Controller/searchGallery /searchText ==" + searchText);
		
		List galleryList = null;
		galleryList = galleryService.search(searchType, searchText);
		
		pager.init(request, galleryList,15,10);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("chimper/chimper/gallery/index");
		mav.addObject("galleryList", galleryList);
		mav.addObject("pager",pager);
		
		System.out.println("Controller/searchGallery/ mav통과");
		return mav;
	}
	
	//메인 페이지 이미지 링크 관련
		@RequestMapping(value="/gallerys/detail/{gallery_image_id}", method=RequestMethod.GET)
		public String getGallery_id(@PathVariable("gallery_image_id")int gallery_image_id) {
			System.out.println("RestController / getGallery_id="+gallery_image_id);
			Gallery_image gallery_image = galleryService.getGallery_id(gallery_image_id);
			System.out.println("Gallery_image =="+gallery_image);
			int result = gallery_image.getGallery().getGallery_id();
			System.out.println("RestController/getGallery_id/DAO통과 ="+result);
			
			return "redirect:/gallerys/"+result+"";
		}
	
	
	/////////////  예외처리 //////////////

	@ExceptionHandler(RegistFailException.class)
	public ModelAndView registFailException(RegistFailException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorpage");
		mav.addObject("err", e);

		return mav;
	}

	@ExceptionHandler(SelectFailException.class)
	public ModelAndView selectFailException(SelectFailException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorpage");
		mav.addObject("err", e);
		return mav;
	}

	@ExceptionHandler(UpdateFailException.class)
	public ModelAndView updateFailException(UpdateFailException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorpage");
		mav.addObject("err", e);
		return mav;
	}

	@ExceptionHandler(DeleteFailException.class)
	public ModelAndView deleteFailException(DeleteFailException e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/errorpage");
		mav.addObject("err", e);
		return mav;
	}

}

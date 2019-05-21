package com.tour.model.gallery.service;

import java.util.List;

import com.tour.model.gallery.domain.Gallery;
import com.tour.model.gallery.domain.Gallery_comment;
import com.tour.model.gallery.domain.Gallery_image;

public interface GalleryService {
	public void insert(Gallery gallery,Gallery_image gallery_image,String path);
	public void delete(int gallery_id,String path);
	public void update(Gallery gallery,Gallery_image gallery_image,String path);
	public void updateHit(int gallery_id);
	public List selectAll();
	public List selectImage(int gallery_id);
	public Gallery select(int gallery_id);
	public void insertConmments(Gallery_comment gallery_comment);
	public List selectComments(int gallery_id);
	public void updateComment(Gallery_comment gallery_comment);
	public void deleteComment(int gallery_comment);
	public List search(String searchType,String searchText);
	public List mainSelectAll();
	public Gallery_image getGallery_id(int gallery_image_id);
}

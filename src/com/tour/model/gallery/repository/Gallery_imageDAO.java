package com.tour.model.gallery.repository;

import java.util.List;

import com.tour.model.gallery.domain.Gallery_image;

public interface Gallery_imageDAO {
	public int insert(Gallery_image gallery_image);
	public int delete(int gallery_image_id);
	public int update(Gallery_image gallery_image);
	public int updateFile(Gallery_image gallery_image);
	public List selectAll();
	public List select(int gallery_id);
	public int deleteAll(int gallery_id);
	public int deleteFile(Gallery_image gallery_image);
	public Gallery_image getGallery_id(int gallery_image_id);
}


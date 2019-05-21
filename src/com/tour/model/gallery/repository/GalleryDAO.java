package com.tour.model.gallery.repository;

import java.util.List;

import com.tour.model.gallery.domain.Gallery;

public interface GalleryDAO {
	public int insert(Gallery gallery);
	public int delete(int gallery_id);
	public int update(Gallery gallery);
	public int updateHit(int gallery_id);
	public List selectAll();
	public Gallery select(int gallery_id);
	public List searchAll();
	public List searchTitle(String searchText);
	public List searchWriter(Gallery gallery);
	public List mainSelectAll();
	public List<Gallery> getMyGallery(int member_id);
}

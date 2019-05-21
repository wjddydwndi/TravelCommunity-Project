package com.tour.model.gallery.repository;

import java.util.List;

import com.tour.model.gallery.domain.Gallery_comment;

public interface Gallery_commentDAO {
	public int insert(Gallery_comment gallery_comment);
	public int delete(int gallery_comment_id);
	public int update(Gallery_comment gallery_comment);
	public List selectAll(int gallery_id);
	public int deleteAll(int gallery_id);
}


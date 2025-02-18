package com.sp.app.service;

import java.util.List;

import com.sp.app.model.Category;
import com.sp.app.model.Funding;

public interface MakerService {
	public void insertProjectRequest(Funding dto) throws Exception;
	public List<Category> listCategory(long num);
}

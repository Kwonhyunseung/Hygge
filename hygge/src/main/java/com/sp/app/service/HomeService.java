package com.sp.app.service;

import java.util.List;

import com.sp.app.model.Category;

public interface HomeService {
	public List<Category> subListCategory(long parent_num);

}

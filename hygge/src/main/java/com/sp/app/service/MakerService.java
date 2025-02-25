package com.sp.app.service;

import java.util.List;

import com.sp.app.model.Category;
import com.sp.app.model.Funding;
import com.sp.app.model.Product;

public interface MakerService {
	public long insertTempProjectRequest(Funding dto, String uploadPath) throws Exception;
	public void updateProjectRequest(long num) throws Exception;

	public void insertProduct(Product dto) throws Exception;

	public List<Category> listCategory(long num);
}

package com.sp.app.service;

import java.util.List;

import com.sp.app.model.Category;
import com.sp.app.model.Funding;
import com.sp.app.model.Maker;
import com.sp.app.model.Product;

public interface MakerService {
	public long insertTempProjectRequest(Funding dto, String uploadPath) throws Exception;
	public void insertProjectRequest(long num);
	public void updateProjectRequest(long num) throws Exception;

	public void insertProduct(Product dto) throws Exception;

	public Maker isMaker(long num);
	public void insertMaker(Maker dto, String uploadPath) throws Exception;
	public void updateMaker(Maker dto, String uploadPath) throws Exception;
	public List<Category> listCategory(long num);
}

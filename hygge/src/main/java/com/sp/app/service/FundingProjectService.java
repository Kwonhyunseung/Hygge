package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Funding;
import com.sp.app.model.Product;

public interface FundingProjectService {
	
	public Funding fundingProduct(long num);
	
	public void calculateProject(Funding project);
	public String convertToString(Double input);
	
	public List<Product> detailProduct(Map<String, Object> map);
	
	public int projectLikeCount(long num);
	public int userFundingLiked(Map<String, Object> map);
	public void insertProjectLikeCount(Map<String, Object> map);
	public void deleteProjectLikeCount(Map<String, Object> map);

    public int userFollowing(Map<String, Object> map);
    public void insertFollowing(Map<String, Object> map);
    public void deleteFollowing(Map<String, Object> map);

}


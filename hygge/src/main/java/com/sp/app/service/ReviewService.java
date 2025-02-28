package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Review;

public interface ReviewService {
	
	void insertReview(Review dto,String uploadPath) throws SQLException;
	
	int reviewCount(long memberIdx);
	
	public List<Review> reviewList(Map<String, Object> map);
	public Review findById(long num);
	public int dataCount(Map<String, Object> map);

	public void deleteReview(long num) throws Exception;
	public void insertFile(Review dto,String uploadPath) throws SQLException;
	
	public List<Review> listFile(long num);
}

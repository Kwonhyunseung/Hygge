package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Review;

public interface ReviewService {
	
	void insertReview(Review dto) throws SQLException;
	
	int reviewCount(long memberIdx);
	
	public List<Review> listReview(Map<String, Object> map);
	public Review findById(long num);

	
}

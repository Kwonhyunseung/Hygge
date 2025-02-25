package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Funding;
import com.sp.app.model.Review;

public interface FundingService {
	public List<Funding> listFundingRequest(Map<String, Object> map);
	public List<Funding> listFunding(Map<String, Object> map);
	public int dataCountFunding(Map<String, Object> map);

	public void insertFundingLike(Map<String, Object> map) throws Exception;
	public void deleteFundingLike(Map<String, Object> map) throws Exception;

	public List<Review> listReview(long num);
}

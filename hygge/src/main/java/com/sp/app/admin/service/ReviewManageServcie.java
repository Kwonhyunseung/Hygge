package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.ReviewManage;

public interface ReviewManageServcie {
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<ReviewManage> reviewList(Map<String, Object> map) throws Exception;
	
	public void deleteReviews(List<Long> reviewIds) throws Exception;
	public List<ReviewManage> categories() throws Exception;
	public void blockMembersByReviews(List<Long> reviewIds) throws Exception;
}

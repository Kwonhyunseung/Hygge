package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Funding;
import com.sp.app.model.Review;

@Mapper
public interface FundingMainMapper {
	public List<Funding> listFundingRequest(Map<String, Object> map);
	public List<Funding> listFunding(Map<String, Object> map);
	public int dataCountFunding(Map<String, Object> map);

	public int isUserLiked(Map<String, Object> map);
	public void insertFundingLike(Map<String, Object> map) throws SQLException;
	public void deleteFundingLike(Map<String, Object> map) throws SQLException;

	public List<Review> listReview(long num);
}

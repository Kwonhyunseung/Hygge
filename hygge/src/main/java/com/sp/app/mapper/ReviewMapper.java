package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Review;

@Mapper
public interface ReviewMapper {
    public int reviewCount(long memberIdx);
    List<Review> reviewList(Map<String, Object> map);
	Review findById(long num);
	public int dataCount(Map<String, Object> map);
	public void insertReview(Review dto) throws SQLException;
	public void deleteReview(long num) throws SQLException;
}

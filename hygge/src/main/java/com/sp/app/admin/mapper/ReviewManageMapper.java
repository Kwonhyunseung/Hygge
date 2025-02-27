package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.ReviewManage;

@Mapper
public interface ReviewManageMapper {
	public int dataCount(Map<String, Object> map) throws SQLException;
	public List<ReviewManage> reviewList(Map<String, Object> map) throws SQLException;
	
	public void deleteReviews(List<Long> reviewIds) throws SQLException;
	public List<ReviewManage> categories() throws SQLException;
	public void blockMembersByReviews(List<Long> reviewIds) throws SQLException;
}

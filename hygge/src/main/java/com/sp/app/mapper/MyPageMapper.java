package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.MyPage;
import com.sp.app.model.Review;

@Mapper
public interface MyPageMapper {
	public MyPage findById(String id) throws SQLException;
	public void ProfileEdit(MyPage dto) throws SQLException;
	public void ProfileEdit2(MyPage dto) throws SQLException;
    int reviewCount(String memberIdx);
    List<Review> listReview(Map<String, Object> map);
	Review findById(long num);
}

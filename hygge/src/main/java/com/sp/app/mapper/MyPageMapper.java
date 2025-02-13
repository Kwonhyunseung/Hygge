package com.sp.app.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.MyPage;

@Mapper
public interface MyPageMapper {
	public MyPage findById(String id) throws SQLException;
}

package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Category;
import com.sp.app.model.Funding;

@Mapper
public interface MakerMapper {
	public long getPR_SEQ();
	public List<Category> listCategory(long num);
	public void insertTempProjectRequest(Funding dto) throws SQLException;
}

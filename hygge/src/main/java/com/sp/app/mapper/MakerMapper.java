package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Category;
import com.sp.app.model.Funding;
import com.sp.app.model.Maker;

@Mapper
public interface MakerMapper {
	public long getPR_SEQ();
	public List<Category> listCategory(long num);
	public void insertTempProjectRequest(Funding dto) throws SQLException;
	public void insertProjectRequest(long num) throws SQLException;
	public void insertProjectPhoto(Funding dto) throws SQLException;
	public void insertProduct(Map<String, Object> map) throws SQLException;

	public void insertMaker(Maker dto) throws SQLException;
	public void updateMaker(Maker dto) throws SQLException;
	public void updateProfile(Map<String, Object> map) throws SQLException;
	public Maker isMaker(long num);
}

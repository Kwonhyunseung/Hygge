package com.sp.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Category;

@Mapper
public interface MakerMapper {
	public List<Category> listCategory(long num);
}

package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Category;
import com.sp.app.model.Funding;

@Mapper
public interface HomeMapper {
	public List<Category> subListCategory(long num);
	
	public List<Funding> listNewProjects(Map<String, Object> map);
	public List<Funding> listPopularProjects(Map<String, Object> map);
	public List<Funding> listDeadlineProjects(Map<String, Object> map);
	public List<Funding> listComingProjects(Map<String, Object> map);

	public List<Funding> listRankingProjects(Map<String, Object> map);
	
	// 카테고리별 프로젝트 목록
    public int getCategoryProjectsCount(Map<String, Object> map);
    public List<Funding> listCategoryProjectsPaging(Map<String, Object> map);
    public List<Funding> listCategoryProjects(Map<String, Object> map);
}

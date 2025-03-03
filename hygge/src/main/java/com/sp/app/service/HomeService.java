package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Category;
import com.sp.app.model.Funding;

public interface HomeService {
	public List<Category> subListCategory(long parent_num);
	
	public List<Funding> listNewProjects(Map<String, Object> map);
	public List<Funding> listPopularProjects(Map<String, Object> map);
	public List<Funding> listDeadlineProjects(Map<String, Object> map);
	public List<Funding> listComingProjects(Map<String, Object> map);
	
	public List<Funding> listRankingProjects(Map<String, Object> map);

}

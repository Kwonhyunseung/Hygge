package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Funding;

public interface WishService {
	public List<Funding> wishProjects(long memberIdx);
    public void removewish(Map<String, Object> map);
}

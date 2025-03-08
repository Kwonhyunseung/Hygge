package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Maker;

public interface FollowService {
	public List<Maker> followingList(long memberIdx);
    public int followCount(long memberIdx);
    public void unfollow(Map<String, Object> map);
}

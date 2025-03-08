package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Maker;

@Mapper
public interface FollowMapper {
	public List<Maker> followingList(long memberIdx);
    public int followCount(long memberIdx);
    public void unfollow(Map<String, Object> map);
}

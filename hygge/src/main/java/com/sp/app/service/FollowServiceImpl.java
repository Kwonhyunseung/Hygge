package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.FollowMapper;
import com.sp.app.model.Maker;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class FollowServiceImpl implements FollowService{
	private final FollowMapper mapper;

	@Override
	public List<Maker> followingList(long memberIdx) {
		List<Maker> list = null;
        try {
            list = mapper.followingList(memberIdx);
        } catch (Exception e) {
            log.info("followingList: ", e);
        }
        return list;
	}

	@Override
	public int followCount(long memberIdx) {
		int result = 0;
        try {
            result = mapper.followCount(memberIdx);
        } catch (Exception e) {
            log.info("followCount: ", e);
        }
        return result;
	}

	@Override
	public void unfollow(Map<String, Object> map) {
		try {
            mapper.unfollow(map);
        } catch (Exception e) {
            log.info("unfollow: ", e);
        }
		
	}
	
}
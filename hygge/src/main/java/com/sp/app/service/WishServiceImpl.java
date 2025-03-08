package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.WishMapper;
import com.sp.app.model.Funding;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class WishServiceImpl implements WishService{
	private final WishMapper mapper;
	
	@Override
	public List<Funding> wishProjects(long memberIdx) {
		List<Funding> list = null;
		try {
            list = mapper.wishProjects(memberIdx);
        } catch (Exception e) {
        	log.info("wishProjects: ", e);
        }
		return list;
	}

	@Override
	public void removewish(Map<String, Object> map) {
        try {
            mapper.removewish(map);
        } catch (Exception e) {
        	log.info("removewish: ", e);
        }
	}

}

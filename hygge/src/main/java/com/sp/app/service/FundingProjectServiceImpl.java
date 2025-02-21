package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.mapper.FundingProjectMapper;
import com.sp.app.model.Funding;
import com.sp.app.model.Product;
import com.sp.app.model.Review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FundingProjectServiceImpl implements FundingProjectService {
	private final FundingProjectMapper mapper;
	private final MyUtil myUtil;

	@Override
	public Funding fundingProduct(long num) {
		Funding dto = null;
		
		try {
			dto = mapper.fundingProduct(num);
		} catch (Exception e) {
			log.info("fundingProduct: ", e);
		}
		
		return dto;
	}

	@Override
	public List<Product> detailProduct(Map<String, Object> map) {
		List<Product> list = null;
		
		try {
			list = mapper.detailProduct(map);
		} catch (Exception e) {
			log.info("detailProduct: ", e);
		}
		
		return list;
	}
	
	@Override
	public int projectLikeCount(long num) {
		int result = 0;
		try {
			result = mapper.projectLikeCount(num);
		} catch (Exception e) {
			log.info("projectLikeCount: ", e);
		}
		return result;
	}

	@Override
	public void insertProjectLikeCount(Map<String, Object> map) {
		try {
			mapper.insertProjectLikeCount(map);
		} catch (Exception e) {
			log.info("insertProjectLikeCount: ", e);
		}
	}

	@Override
	public void deleteProjectLikeCount(Map<String, Object> map) {
		try {
			mapper.deleteProjectLikeCount(map);
		} catch (Exception e) {
			log.info("deleteProjectLikeCount: ", e);
		}
		
	}

	@Override
	public int userFundingLiked(Map<String, Object> map) {
	    int result = 0;
	    try {
	        result = mapper.userFundingLiked(map);
	    } catch (Exception e) {
	        log.info("userFundingLiked: ", e);
	    }
	    return result;
	}
	
	@Override
	public List<Review> listProductReview(Map<String, Object> map) {
		List<Review> list = null;
		
		try {
			list = mapper.listProductReview(map);
			
			for(Review dto : list) {
				dto.setMemberName(myUtil.nameMasking(dto.getMemberName()));
				
				
			}
			
		} catch (Exception e) {
			log.info("listProductReview: ", e);
		}
		return list;
	}
	
	
}
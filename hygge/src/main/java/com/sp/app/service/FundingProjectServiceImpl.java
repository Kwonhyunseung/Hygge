package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.FundingProjectMapper;
import com.sp.app.model.Funding;
import com.sp.app.model.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FundingProjectServiceImpl implements FundingProjectService {
	private final FundingProjectMapper mapper;

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
	public int totalAmountProduct(long num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int projectLikeCount(long num) {
		// TODO Auto-generated method stub
		return 0;
	}


}
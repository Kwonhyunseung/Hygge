package com.sp.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.FundingProjectMapper;
import com.sp.app.model.Funding;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FundingProjectServiceImpl implements FundingProjectService {
	private final FundingProjectMapper mapper;

	@Override
	public Funding detailProduct(long num) {
		Funding funding = null;
		
		try {
			funding = mapper.detailProduct(num);
		} catch (Exception e) {
			log.info("detailProduct: ", e);
		}
		return funding;
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

	@Override
	public List<Funding> productReviews(long num) {
		// TODO Auto-generated method stub
		return null;
	}

}
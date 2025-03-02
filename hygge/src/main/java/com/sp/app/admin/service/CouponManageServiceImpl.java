package com.sp.app.admin.service;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.CouponManageMapper;
import com.sp.app.admin.model.CouponManage;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CouponManageServiceImpl implements CouponManageService{
	private final CouponManageMapper mapper;
	
	@Override
	public void insertCoupon(CouponManage dto) throws Exception {
		mapper.insertCoupon(dto);
	}
}

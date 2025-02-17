package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.CouponMapper;
import com.sp.app.model.Coupon;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class CouponServiceImpl implements CouponService{
	
	private final CouponMapper mapper;
	
	@Override
	public void insertCoupon(Coupon dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateCoupon(Coupon dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCoupon(Coupon dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Coupon> listCoupon(Map<String, Object> map) {
		List<Coupon> list = null;
		try {
			list = mapper.listCoupon(map);
		} catch (Exception e) {
			log.info("쿠폰 리스트 오류 : ", e);
		}
		return list;
	}

	@Override
	public int couponCount(long memberIdx) {
		try {
			return mapper.couponCount(memberIdx);
		} catch (Exception e) {
			log.info("쿠폰 개수쪽 오류 : ", e);
			throw e;
		}
	}

}

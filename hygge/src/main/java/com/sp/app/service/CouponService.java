package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Coupon;

public interface CouponService {
	public void insertCoupon(Coupon dto) throws SQLException;
	public void updateCoupon(Coupon dto) throws SQLException;
	public void deleteCoupon(Coupon dto) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<Coupon> listCoupon(Map<String, Object> map);
	public int couponCount(long memberIdx);
}

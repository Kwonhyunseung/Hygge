package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Coupon;

@Mapper
public interface CouponMapper {
	public void insertCoupon(Coupon dto) throws SQLException;
	public void updateCoupon(Coupon dto) throws SQLException;
	public void deleteCoupon(Coupon dto) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<Coupon> listCoupon(Map<String, Object> map);
	public int couponCount(long memberIdx);

}

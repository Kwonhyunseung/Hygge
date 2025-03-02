package com.sp.app.admin.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.CouponManage;

@Mapper
public interface CouponManageMapper {
	public void insertCoupon(CouponManage dto) throws Exception;
}

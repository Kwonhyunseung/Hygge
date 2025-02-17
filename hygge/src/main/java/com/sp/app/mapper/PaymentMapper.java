package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Payment;

@Mapper
public interface PaymentMapper {
	public List<Payment> paymentList(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
}

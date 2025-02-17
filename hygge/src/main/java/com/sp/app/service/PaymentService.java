package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Payment;

public interface PaymentService {
	public List<Payment> paymentList(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
}

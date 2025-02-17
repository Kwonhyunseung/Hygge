package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.PaymentMapper;
import com.sp.app.model.Payment;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PaymentServiceImpl implements PaymentService{
	
	private final PaymentMapper mapper;
	
	
	@Override
	public List<Payment> paymentList(Map<String, Object> map) {
		List<Payment> list = null;
		try {
			list = mapper.paymentList(map);
		} catch (Exception e) {
			log.info("구매내역 오류 : ",e);
			throw e;
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}

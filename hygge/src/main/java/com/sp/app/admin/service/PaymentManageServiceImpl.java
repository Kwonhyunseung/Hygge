package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.PaymentManageMapper;
import com.sp.app.admin.model.PaymentManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PaymentManageServiceImpl implements PaymentManageService  {
    private final PaymentManageMapper mapper;
    
    @Override
    public int dataCount(Map<String, Object> map) throws Exception {
        int result = 0;
        
        try {
            result = mapper.dataCount(map);
        } catch (Exception e) {
            log.error("dataCount 에러", e);
            throw e;
        }
        
        return result;
    }
    
    @Override
    public List<PaymentManage> listPurchase(Map<String, Object> map) throws Exception {
        List<PaymentManage> list = null;
        
        try {
            list = mapper.listPurchase(map);
        } catch (Exception e) {
            log.error("listPurchase 에러", e);
            throw e;
        }
        
        return list;
    }
    
    @Override
    public PaymentManage findByPayment(long payment_num) throws Exception {
    	PaymentManage dto = null;
        
        try {
            dto = mapper.findByPayment(payment_num);
        } catch (Exception e) {
            log.error("findByPayment 에러", e);
            throw e;
        }
        
        return dto;
    }
    
    @Override
    public List<PaymentManage> listSalesByPayment(long payment_num) throws Exception {
        List<PaymentManage> list = null;
        
        try {
            list = mapper.listSalesByPayment(payment_num);
        } catch (Exception e) {
            log.error("listSalesByPayment 에러", e);
            throw e;
        }
        
        return list;
    }
    
    @Override
    @Transactional
    public void insertRefund(Map<String, Object> map) throws Exception {
        try {
            // 환불 정보 삽입
            mapper.insertRefund(map);
            
            // 결제 상태 업데이트 (환불 처리 상태로)
            mapper.updatePaymentState(map);
        } catch (Exception e) {
            log.error("insertRefund 에러", e);
            throw e;
        }
    }
}
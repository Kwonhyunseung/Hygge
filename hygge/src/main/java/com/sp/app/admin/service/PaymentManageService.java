package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.PaymentManage;

public interface PaymentManageService {
    public int dataCount(Map<String, Object> map) throws Exception;
    public List<PaymentManage> listPurchase(Map<String, Object> map) throws Exception;
    public PaymentManage findByPayment(long payment_num) throws Exception;
    public List<PaymentManage> listSalesByPayment(long payment_num) throws Exception;
    public void insertRefund(Map<String, Object> map) throws Exception;
}

package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.PaymentManage;

@Mapper
public interface PaymentManageMapper {
    public int dataCount(Map<String, Object> map);
    public List<PaymentManage> listPurchase(Map<String, Object> map);
    public PaymentManage findByPayment(long payment_num);
    public List<PaymentManage> listSalesByPayment(long payment_num);
    public void insertRefund(Map<String, Object> map);
    public void updatePaymentState(Map<String, Object> map);
}

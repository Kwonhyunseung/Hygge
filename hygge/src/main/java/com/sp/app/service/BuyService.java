package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Coupon;
import com.sp.app.model.DeliveryList;
import com.sp.app.model.Member;
import com.sp.app.model.Payment;
import com.sp.app.model.Product;

public interface BuyService {
	// productList
		public List<Product> productList(Map<String, Object> map);
		public Product findByProductNum(long num);
		
		// productChoice
			//public Product buyProductAllInfo(Map<String, Object> map);
		public Product buyProductInfo(long num) throws Exception;
		public Member buyUserInfo(long memberIdx) throws Exception;
		
		public void insertBuyDelivery(DeliveryList dto) throws Exception;
		public void insertBuyPayment(Payment dto) throws Exception;
		
		public List<Coupon> listCoupon(Long memberIdx);
	    public void updateCoupon(Coupon dto) throws Exception;
	    
	    public void updateStock(Product dto) throws Exception;
}

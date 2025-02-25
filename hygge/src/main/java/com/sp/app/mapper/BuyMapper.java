package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Coupon;
import com.sp.app.model.DeliveryList;
import com.sp.app.model.Member;
import com.sp.app.model.Payment;
import com.sp.app.model.Product;

@Mapper
public interface BuyMapper {
	// productList
	public List<Product> productList(Map<String, Object> map);
	public Product findByProductNum(long num);
	
	// productChoice
		//public Product buyProductAllInfo(Map<String, Object> map);
	public Product buyProductInfo(long num) throws SQLException;
	public Member buyUserInfo(long memberIdx) throws SQLException;
	
	public void insertBuyDelivery(DeliveryList dto) throws SQLException;
	public void insertBuyPayment(Payment dto) throws SQLException;
	
	public List<Coupon> listCoupon(Long memberIdx);
    public void updateCoupon(Coupon dto) throws SQLException;
    
    public void updateStock(Product dto) throws SQLException;
}
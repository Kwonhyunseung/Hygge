package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.DeliveryList;
import com.sp.app.model.Event;
import com.sp.app.model.Payment;
import com.sp.app.model.Product;

@Mapper
public interface BuyMapper {
	// productList
	public List<Product> productList(Map<String, Object> map);
	public Product findByProductNum(long num);
	
	// productChoice
	public Product buyProductAllInfo(long num);
	
	public void insertBuyDelivery(DeliveryList dto) throws SQLException;
	public void insertBuyPayment(Payment dto) throws SQLException;
	
	//public List<Event> couponList(Map<String, Object> map);
	public List<Event> listAvailableCoupons(Long memberIdx);
	//public void updateCoupon(Event dto) throws SQLException;
    public int updateCouponUsage(Map<String, Object> map) throws SQLException;
    
	//public void updateProductStock(Product dto) throws SQLException;
    public int updateStock(Map<String, Object> map) throws SQLException;
}
package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Buy;
import com.sp.app.model.Product;

public interface BuyService {

	public List<Product> productList(Map<String, Object> map); //구매 - 상품리스트
	
	public Product findByProductNum(long num); //상품 선택
	
	// 결제
	public void insertBuy(Buy dto) throws SQLException;
	public void insertBuyCoupon(Buy dto) throws SQLException;
	public void insertBuyDelivery(Buy dto) throws SQLException;
	
	public void updateProductStock(Buy dto) throws SQLException;
	
	public Buy findByBuyProduct(long payment_num);
	
	public List<Buy> listBuyProduct(List<Map<String, Long>> list);

}

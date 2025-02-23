package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Buy;
import com.sp.app.model.Payment;
import com.sp.app.model.Product;

@Mapper
public interface BuyMapper {
	// productList
	public List<Product> productList(Map<String, Object> map);
	public Product findByProductNum(long num);
	
	// productChoice
	public String findByMaxBuyNum();
	
	public List<Buy> buyProductAllInfo(long num); // 상품정보(상품명, 상품구성, 구매수량, 결제금액) 서포터정보(이름, 이메일, 핸드폰번호) 배송지정보(받는사람=>유저, 주소1,2, 우편번호)
	
	public void insertBuy(Buy dto) throws SQLException; //주문 등록(구매상품명, 이름, 수량, 배송지, 결제금액)
	public void insertBuyDetail() throws SQLException; //주문상세정보 등록
	public void insertBuyDelivery(Buy dto) throws SQLException; //배송지 등록(신규 배송지일 경우)
	public void insertBuyCoupon(Buy dto) throws SQLException; //쿠폰 등록
	public void insertBuyPayment(Payment dto) throws SQLException; //결제내역 등록
	
	public void updateProductStock(Buy dto) throws SQLException;// 판매 개수에 따른 재고 감소
	
	
}
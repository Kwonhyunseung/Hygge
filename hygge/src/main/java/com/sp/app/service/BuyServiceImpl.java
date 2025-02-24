package com.sp.app.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ConcurrentModificationException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.mapper.BuyMapper;
import com.sp.app.model.DeliveryList;
import com.sp.app.model.Event;
import com.sp.app.model.Payment;
import com.sp.app.model.Product;
import com.sp.app.model.Sales;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BuyServiceImpl implements BuyService {
	private final BuyMapper mapper;
	
	@Override
	public List<Product> productList(Map<String, Object> map) {
		List<Product> list = null;
		
		try {
			list = mapper.productList(map);
			
			// 각 상품의 배송일정 포맷팅
	        if(list != null) {
	            for(Product p : list) {
	                String formattedDate = formatDeliveryDate(p.getDelivery_info());
	                p.setDelivery_info(formattedDate);
	            }
	        }
		} catch (Exception e) {
			log.info("productList: ", e);
		}
		return list;
	}
	
	// 날짜 파싱
	private String formatDeliveryDate(String dateString) {
	    try {
	        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
	        
	        // 1. yyyyMMdd 형식
	        if (dateString.matches("\\d{8}")) {
	            LocalDate date = LocalDate.parse(dateString, 
	                DateTimeFormatter.ofPattern("yyyyMMdd"));
	            return date.format(outputFormatter);
	        }
	        
	        // 2. yyyy-MM-dd 형식
	        if (dateString.matches("\\d{4}-\\d{2}-\\d{2}")) {
	            LocalDate date = LocalDate.parse(dateString);
	            return date.format(outputFormatter);
	        }
	        
	        // 3. yyyy.MM.dd 형식
	        if (dateString.matches("\\d{4}\\.\\d{2}\\.\\d{2}")) {
	            LocalDate date = LocalDate.parse(dateString.replace(".", "-"));
	            return date.format(outputFormatter);
	        }
	        
	        return dateString; // 원본 반환
	    } catch (Exception e) {
	        return dateString;
	    }
	}

	@Override
	public Product findByProductNum(long num) {
		Product dto = null;
		
		try {
			dto = mapper.findByProductNum(num);
		} catch (Exception e) {
			log.info("findByProductNum: ", e);
		}
		return dto;
	}

	@Override
	public Product buyProductAllInfo(long num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertBuyDelivery(DeliveryList dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertBuyPayment(Payment dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Event> couponList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateCoupon(Event dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateProductStock(Product dto) throws SQLException {
		// TODO Auto-generated method stub
		
		
	}
	/*
	@Transactional
	public boolean processPurchase(Sales sales) {
	    // 1. 재고 확인
	    Product product = productMapper.selectProduct(sales.getProduct_num());
	    if (product.getStock() < sales.getAmount()) {
	        throw new OutOfStockException("재고가 부족합니다");
	    }
	    
	    // 2. 재고 업데이트
	    Map<String, Object> params = new HashMap<>();
	    params.put("product_num", sales.getProduct_num());
	    params.put("amount", sales.getAmount());
	    
	    int updated = productMapper.updateProductStock(params);
	    if (updated == 0) {
	        throw new ConcurrentModificationException("재고 업데이트에 실패했습니다");
	    }
	    
	    // 3. 판매 정보 저장
	    salesMapper.insertSales(sales);
	    
	    return true;
	}
	*/

	
	
}
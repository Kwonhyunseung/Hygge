package com.sp.app.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.BuyMapper;
import com.sp.app.model.Coupon;
import com.sp.app.model.DeliveryList;
import com.sp.app.model.Member;
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
	public Product buyProductInfo(long num) throws SQLException {
		Product dto = null;
		try {
			dto = mapper.buyProductInfo(num);
		} catch (Exception e) {
			log.info("buyProductInfo: ", e);
		}
		return dto;
	}

	@Override
	public Member buyUserInfo(long memberIdx) throws SQLException {
		Member dto = null;
		try {
			dto = mapper.buyUserInfo(memberIdx);
		} catch (Exception e) {
			log.info("buyProductInfo: ", e);
		}
		return dto;
	}
	
	@Override
	public void insertBuyDelivery(DeliveryList dto) throws Exception {
		try {
			mapper.insertBuyDelivery(dto);
		} catch (Exception e) {
			log.info("insertBuyDelivery: ", e);
		}
	}

	@Override
	public void insertBuySales(Sales dto) throws Exception {
		try {
			mapper.insertBuySales(dto);
		} catch (Exception e) {
			log.info("insertBuySales: ", e);
		}
		
	}
	
	@Override
	public void insertBuyPayment(Payment dto) throws Exception {
		try {
			mapper.insertBuyPayment(dto);
		} catch (Exception e) {
			log.info("insertBuyPayment: ", e);
		}
	}

	@Override
	public List<Coupon> listCoupon(Long memberIdx) {
		List<Coupon> list = null;
		try {
			list = mapper.listCoupon(memberIdx);
		} catch (Exception e) {
			log.info("listCoupon: ", e);
		}
		return list;
	}

	@Override
	public void updateCoupon(Coupon dto) throws Exception {
		try {
			mapper.updateCoupon(dto);
		} catch (Exception e) {
			log.info("updateCoupon: ", e);
		}
	}

	@Override
	public void updateStock(Product dto) throws Exception {
		try {
			mapper.updateStock(dto);
		} catch (Exception e) {
			log.info("updateStock: ", e);
		}
	}
	

}
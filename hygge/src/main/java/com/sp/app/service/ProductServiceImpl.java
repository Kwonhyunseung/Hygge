package com.sp.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ProductMapper;
import com.sp.app.model.Product;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductServiceImpl implements ProductService{
	private final ProductMapper mapper;

	@Override
	public Product detailProduct(long product_num) {
		Product dto = null;
		try {
			dto = mapper.detailProduct(product_num);
			log.info("Fetched product: " + dto); // 로그 추가
		} catch (Exception e) {
			log.info("detailProduct: ", e);
		}
		return dto;
	}

	
	
	@Override
	public int totalAmountProduct(long product_num) {
		int result = 0;
		try {
			result = mapper.totalAmountProduct(product_num);
		} catch (Exception e) {
			log.info("totalAmountProduct: ", e);
		}
		return result;
	}

	
	@Override
	public int projectLikeCount(long product_num) {
		// TODO Auto-generated method stub
		return 0;
	}
	

	@Override
	public List<Product> productReviews(long product_num) {
		// TODO Auto-generated method stub
		return null;
	}



	
}
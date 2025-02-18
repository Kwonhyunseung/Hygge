package com.sp.app.service;

import java.util.List;
import java.util.Map;

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
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount: ", e);
		}
		return result;
	}

	@Override
	public List<Product> listProduct(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public Product detailProduct(long product_num) {
		try {
			mapper.detailProduct(product_num);
		} catch (Exception e) {
			log.info("detailProduct: ", e);
		}
		
		return null;
	}

	@Override
	public Product findByNum(long productNum) {
		Product dto = null;
		
		try {
			dto = mapper.findByNum(productNum);
		} catch (Exception e) {
			log.info("findByNum: ", e);
		}
		
		return dto;
	}

	/*
	@Override
	public Product findByCategoryNum(long productNum) {
		// TODO Auto-generated method stub
		return null;
	}
	*/

	@Override
	public List<Product> listAllCategory() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> listCategory() {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public List<Product> listSubCategory(long productNum) {
		// TODO Auto-generated method stub
		return null;
	}
	

	@Override
	public List<Product> listProductOption(long productNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Product> listOptionStock(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int searchCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Product> listSearchProduct(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}


}

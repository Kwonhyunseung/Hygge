package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Product;

public interface ProductService {
	public int dataCount(Map<String, Object> map);
	public List<Product> listProduct(Map<String, Object> map);
	public Product detailProduct(long product_num); //펀딩상세화면
	
	public Product findByNum(long productNum);
	/* public Product findByCategoryNum(long productNum); */
	
	public List<Product> listAllCategory();
	public List<Product> listCategory();
	public List<Product> listSubCategory(long product_num);
	
	public List<Product> listProductOption(long product_num);
	public List<Product> listOptionStock(Map<String, Object> map);
	
	public int searchCount(Map<String, Object> map);
	public List<Product> listSearchProduct(Map<String, Object> map);
}

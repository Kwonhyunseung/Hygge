package com.sp.app.service;

import java.util.List;

import com.sp.app.model.Product;

public interface ProductService {
	public Product detailProduct(long product_num); //프로젝트 상세화면
	public int totalAmountProduct(long product_num); //모인 금액
	public int projectLikeCount(long product_num); //프로젝트 좋아요수
	public List<Product> productReviews(long product_num); //프로젝트 후기
	
}

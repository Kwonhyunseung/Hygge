package com.sp.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Product;

@Mapper
public interface ProductMapper {
	public Product detailProduct(long product_num); //프로젝트 상세화면
	public int totalAmountProduct(long product_num); //모인 금액
	public int projectLikeCount(long product_num); //프로젝트 좋아요수
	public List<Product> productReviews(long product_num); //프로젝트 후기
	
}
package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Funding;
import com.sp.app.model.Product;

@Mapper
public interface FundingProjectMapper {
	
	public Funding fundingProduct(long num); //프로젝트 상세화면 - 상단 메인 정보
	
	/*public Funding detailProduct(long num);*/
	public List<Product> detailProduct(Map<String, Object> map); //프로젝트 상세화면 - 상품구성
	
	public int totalAmountProduct(long num); //모인 금액
	
	public int projectLikeCount(long num); //프로젝트 좋아요수
	
	//프로젝트 후기
	
}
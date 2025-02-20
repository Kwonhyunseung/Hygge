package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Funding;
import com.sp.app.model.Product;
import com.sp.app.model.Review;

@Mapper
public interface FundingProjectMapper {
	
	public Funding fundingProduct(long num); //프로젝트 상세화면 - 상단 메인 정보
	
	public List<Product> detailProduct(Map<String, Object> map); //프로젝트 상세화면 - 상품구성
	
	public int projectLikeCount(long num); //프로젝트 좋아요수
	public void insertProjectLikeCount(Map<String, Object> map);
	public void deleteProjectLikeCount(Map<String, Object> map);
	public int userFundingLiked(Map<String, Object> map);
	
	public List<Review> listProductReview(Map<String, Object> map); //프로젝트 - 후기 리스트
	// 후기는 마이페이지에서 내가 산 물품 후기 작성 가능
	// 펀딩 화면은 후기 리스트만 보이게?
	
	// ------------
	public int totalAmountProduct(long num); //모인 금액
	
}
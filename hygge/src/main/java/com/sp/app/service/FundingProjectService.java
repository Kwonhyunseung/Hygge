package com.sp.app.service;

import java.util.List;

import com.sp.app.model.Funding;

public interface FundingProjectService {
	public Funding detailProduct(long num); //프로젝트 상세화면
	public int totalAmountProduct(long num); //모인 금액
	public int projectLikeCount(long num); //프로젝트 좋아요수
	public List<Funding> productReviews(long num); //프로젝트 후기
	
}

package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Funding;

public interface FundingService {
	public List<Funding> listFundingRequest(Map<String, Object> map);
	public List<Funding> listFunding(Map<String, Object> map);
}

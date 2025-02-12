package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Funding;

@Mapper
public interface FundingMainMapper {
	public List<Funding> listFunding(Map<String, Object> map);
}

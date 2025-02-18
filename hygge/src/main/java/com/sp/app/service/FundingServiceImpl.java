package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.FundingMainMapper;
import com.sp.app.model.Funding;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FundingServiceImpl implements FundingService {
	private final FundingMainMapper mapper;

	@Override
	public List<Funding> listFunding(Map<String, Object> map) {
		List<Funding> list = null;
		try {
			list = mapper.listFunding(map);
			if (map.get("memberIdx") == null) {
				return list;
			}
			for (Funding dto : list) {
				map.put("num", dto.getNum());
				if (mapper.isUserLiked(map) != 0) {
					dto.setUserLiked(true);
				} else {
					dto.setUserLiked(false);
				}
				dto.setProgress(dto.getTotal_amount() / dto.getTarget() * 100);
			}
		} catch (Exception e) {
			log.info("listFunding : ", e);
		}
		return list;
	}

	@Override
	public List<Funding> listFundingRequest(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataCountFunding(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCountFunding(map);
		} catch (Exception e) {
			log.info("dataCountFunding : ", e);
		}
		return result;
	}

	@Override
	public void insertFundingLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertFundingLike(map);
		} catch (Exception e) {
			log.info("insertFundingLike : ", e);
			throw e;
		}
	}

	@Override
	public void deleteFundingLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteFundingLike(map);
		} catch (Exception e) {
			log.info("deleteFundingLike : ", e);
			throw e;
		}
	}

}

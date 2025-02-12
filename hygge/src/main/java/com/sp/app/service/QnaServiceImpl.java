package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.QnaMapper;
import com.sp.app.model.Qna;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class QnaServiceImpl implements QnaService {
	private final QnaMapper mapper;
	
	
	@Override
	public void insertQna(Qna qna) throws Exception {
		try {
			mapper.insertQna(qna);
		} catch (Exception e) {

			log.info("insertQuestion : ", e);
			
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<Qna> listQna(Map<String, Object> map) {
		List<Qna> list = null;
		try {
			list = mapper.listQna(map);
		} catch (Exception e) {
			log.info("listQna : ", e);
		}
		return list;
	}

	@Override
	public Qna findById(long num) {
		Qna dto = null;
		
		try {
			dto = mapper.findById(num);
		} catch (Exception e) {
			log.info("findById : ", e);
		
		}
		
		return dto;
	}

	@Override
	public Qna findByPrev(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Qna findByNext(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateQna(Qna qna) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteQna(long num) throws Exception {
		// TODO Auto-generated method stub
		
	}

    
}

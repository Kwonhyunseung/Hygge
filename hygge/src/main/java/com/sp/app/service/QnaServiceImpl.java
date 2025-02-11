package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.model.Qna;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class QnaServiceImpl implements QnaService {@Override
	public void insertQna(Qna dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Qna> listQna(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Qna findById(long num) {
		// TODO Auto-generated method stub
		return null;
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
	public void updateQna(Qna dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteQna(long num) throws Exception {
		// TODO Auto-generated method stub
		
	}

    
}

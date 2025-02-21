package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.mapper.MakerBoardMapper;
import com.sp.app.model.MakerBoard;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MakerBoardServiceImpl implements MakerBoardService{
	
	@Autowired
	private final MakerBoardMapper mapper;
	
	
	@Override
	public List<MakerBoard> listBoard(Map<String, Object> map) {
		List<MakerBoard> list = null;
		
		try {
			list = mapper.listBoard(map);
		} catch (Exception e) {
			log.info("list 호출 오류 ", e);
		}
		
		return list;
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
	public void insertBoardLike(Map<String, Object> map) throws SQLException {
		try {
			mapper.insertBoardLike(map);
		} catch (Exception e) {
			log.info("좋아요 인서트 오류",e);
		}
		
	}

	@Override
	public void deleteBoardLike(Map<String, Object> map) throws SQLException {
		try {
			mapper.deleteBoardLike(map);
		} catch (Exception e) {
			log.info("좋아요 딜리트 오류",e);
		}
		
		
	}


	@Override
	public int countLike(long num) {
		int result = 0;
		try {
			result = mapper.countLike(num);
		} catch (Exception e) {
			log.info("좋아요 카운트 오류",e);
		}
		return result;
	}

	@Override
	public int userBoardLiked(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.userBoardLiked(map);
		} catch (Exception e) {
			log.info("좋아요 오류",e);
		}
		return result;
	}
	
	@Override
	public void insertBoard(MakerBoard dto) throws SQLException {
		try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	@Override
	public void updateBoard(MakerBoard dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoard(MakerBoard dto) throws SQLException {
		// TODO Auto-generated method stub
		
	}



}

package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.MakerBoard;

public interface MakerBoardService {
	
	public List<MakerBoard> listBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public int countLike (long num);
	
	public int userBoardLiked(Map<String, Object> map);
	public void insertBoardLike(Map<String, Object> map) throws SQLException;
	public void deleteBoardLike(Map<String, Object> map) throws SQLException;
	
	public void insertBoard(MakerBoard dto) throws SQLException;
	public void updateBoard(MakerBoard dto) throws SQLException;
	public void deleteBoard(MakerBoard dto) throws SQLException;
}

package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.MakerBoard;

@Mapper
public interface MakerBoardMapper {
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

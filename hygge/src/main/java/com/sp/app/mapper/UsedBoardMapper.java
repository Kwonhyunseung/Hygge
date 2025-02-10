package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.UsedBoard;

@Mapper
public interface UsedBoardMapper {
	public long seqValue();
	public void insertBoard(UsedBoard dto) throws SQLException;
	public void insertBoardFile(Map<String, Object> map) throws SQLException;
	public void updateBoard(UsedBoard dto) throws SQLException;
	public void deleteBoard(long num) throws SQLException;

	public int dataCount(Map<String, Object> map);
	public List<UsedBoard> listBoard(Map<String, Object> map);

	public UsedBoard findById(long num);
	public void updateHitCount(long num) throws SQLException;
	public UsedBoard findByPrev(Map<String, Object> map);
	public UsedBoard findByNext(Map<String, Object> map);
}

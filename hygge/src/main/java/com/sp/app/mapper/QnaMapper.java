package com.sp.app.mapper;

import com.sp.app.model.Qna;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;

@Mapper
public interface QnaMapper {
	public void insertQna(Qna dto) throws SQLException;
	public void updateQna(Qna dto) throws SQLException;
	public void updateAnswer(Qna dto) throws SQLException;
	public void deleteQna(long num) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<Qna> listQna(Map<String, Object> map);
	
	public Qna findById(long num);
	public Qna findByPrev(Map<String, Object> map);
	public Qna findByNext(Map<String, Object> map);
}

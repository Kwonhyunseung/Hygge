package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.EventManage;

@Mapper
public interface EventManageMapper {
	public List<EventManage> listEvent(Map<String, Object> map) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	
	public void insertEvent(EventManage dto);
	
	public EventManage readEvent(long num);
	public void updateEvent(EventManage dto);
	public void deleteEvent(long num) throws SQLException;
}

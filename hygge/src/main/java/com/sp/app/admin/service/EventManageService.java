package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.EventManage;

public interface EventManageService {
	public List<EventManage> listEvent(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public void insertEvent(EventManage dto, String pathname) throws Exception;
	
	public EventManage readEvent(long num) throws Exception;
	public void updateEvent (EventManage dto, String pathname) throws Exception;
	public void deleteEvent (long num, String pathname) throws Exception;
	

}

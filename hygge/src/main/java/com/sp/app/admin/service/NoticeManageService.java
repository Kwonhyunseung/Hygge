package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.NoticeManage;

public interface NoticeManageService {
	public void insertNotice(NoticeManage dto, String pathname) throws Exception;
	
	public List<NoticeManage> listNotice(Map<String, Object> map);
	public int dataCount(Map<String, Object> map) throws Exception;
	
    public NoticeManage findById(long num);
    public NoticeManage findByPrev(Map<String, Object> map);
    public NoticeManage findByNext(Map<String, Object> map);
    public List<NoticeManage> listNoticeFile(long num);
    public void updateNotice(NoticeManage dto, String pathname);
    public void deleteNoticeFile(long num, String pathname) throws Exception;
    public void deleteNotice(long num, String pathname) throws Exception;
    
    public void deleteNotices(List<Long> nums, String pathname) throws Exception;
    
}

package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.NoticeManage;

@Mapper
public interface NoticeManageMapper {
    public void insertNotice(NoticeManage dto)throws SQLException;
    public void insertNoticeFile(NoticeManage dto) throws SQLException;
    
    public List<NoticeManage> listNotice(Map<String, Object> map);
    public int dataCount(Map<String, Object> map) throws SQLException;
    
    public NoticeManage findById(long num);
    public NoticeManage findByPrev(Map<String, Object> map);
    public NoticeManage findByNext(Map<String, Object> map);
    public List<NoticeManage> listNoticeFile(long num);
    public void updateNotice(NoticeManage dto) throws SQLException;
    public void deleteNoticeFile(long num) throws SQLException;
    public void deleteNotice(long num) throws SQLException;
    public void deleteAllNoticeFiles(long num) throws SQLException;
}

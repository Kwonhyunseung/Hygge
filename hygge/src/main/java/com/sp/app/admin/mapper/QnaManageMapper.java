package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.QnaManage;

@Mapper
public interface QnaManageMapper {
    public List<QnaManage> qnaList(Map<String, Object> map);
    public int dataCount(Map<String, Object> map);
    public Map<String, Object> getStatusCounts();
    
    public List<Map<String, Object>> getCategoryList();
    public void answerQna(Map<String, Object> map);
}

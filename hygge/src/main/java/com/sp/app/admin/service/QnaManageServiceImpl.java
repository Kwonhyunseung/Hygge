package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.QnaManageMapper;
import com.sp.app.admin.model.QnaManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class QnaManageServiceImpl implements QnaManageService{
    private final QnaManageMapper mapper;
    
    @Override
    public List<QnaManage> qnaList(Map<String, Object> map) {
        return mapper.qnaList(map);
    }
    
    @Override
    public int dataCount(Map<String, Object> map) {
        return mapper.dataCount(map);
    }
    
    @Override
    public Map<String, Object> getStatusCounts() {
        return mapper.getStatusCounts();
    }

	@Override
	public List<Map<String, Object>> getCategoryList() throws Exception {
		return mapper.getCategoryList();
	}


}

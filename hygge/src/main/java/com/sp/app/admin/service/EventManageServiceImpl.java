package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import com.sp.app.admin.mapper.EventManageMapper;
import com.sp.app.admin.model.EventManage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import java.util.Base64;

@Service
@RequiredArgsConstructor
@Slf4j
public class EventManageServiceImpl implements EventManageService {
    private final EventManageMapper mapper;
    
    @Override
    public List<EventManage> listEvent(Map<String, Object> map) throws Exception {
    	
        List<EventManage> events = mapper.listEvent(map);
        
        return events;
    }

    @Override
    public int dataCount(Map<String, Object> map) throws Exception {
        return mapper.dataCount(map);
    }

    @Override
    public void insertEvent(EventManage dto) throws Exception {
        try {
            mapper.insertEvent(dto);
        } catch (Exception e) {
            log.info("insertEvent : ", e);
            throw e;
        }
    }
}
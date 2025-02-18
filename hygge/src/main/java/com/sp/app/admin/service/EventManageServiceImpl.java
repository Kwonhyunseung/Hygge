package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.mapper.EventManageMapper;
import com.sp.app.admin.model.EventManage;
import com.sp.app.common.FileManager;
import com.sp.app.common.MyUtil;
import com.sp.app.common.StorageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import java.util.Base64;

@Service
@RequiredArgsConstructor
@Slf4j
public class EventManageServiceImpl implements EventManageService {
    private final EventManageMapper mapper;
    private final StorageService storageService;
    
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
	public void insertEvent(EventManage dto, String pathname) throws Exception {
		try {
			String filename = null;
			MultipartFile mf = dto.getPhotoFile();
			if(mf != null && !mf.isEmpty()) {
				filename = storageService.uploadFileToServer(mf, filename);
				dto.setPhoto(filename);
			}
			
			mapper.insertEvent(dto);
		} catch (Exception e) {
			log.info("insertEvent : ", e);
		}
		
	}

	@Override
	public EventManage readEvent(long num) throws Exception {
        EventManage dto = null;
        try {
            dto = mapper.readEvent(num);
        } catch (Exception e) {
            throw e;
        }
        return dto;
	}

	@Override
	public void updateEvent(EventManage dto, String pathname) throws Exception {
		try {
			String filename = null;
			MultipartFile mf = dto.getPhotoFile();
			if(mf != null && !mf.isEmpty()) {
				EventManage oldDto = readEvent(dto.getNum());
				
				if(oldDto.getPhoto() != null) {
					storageService.deleteFile(pathname, oldDto.getPhoto());
				}
				
				filename = storageService.uploadFileToServer(mf, filename);
				dto.setPhoto(filename);
			}
			mapper.updateEvent(dto);
		} catch (Exception e) {
			log.info("updateEvent : ", e);
		}
	}

	@Override
	public void deleteEvent(long num, String pathname) throws Exception {
		try {
			EventManage dto = readEvent(num);
			if(dto.getPhoto() != null) {
				storageService.deleteFile(pathname, dto.getPhoto());
			}
			
			mapper.deleteEvent(num);
		} catch (Exception e) {
			log.info("deleteEvent : ", e );
		}
	}
}
package com.sp.app.admin.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.mapper.EventManageMapper;
import com.sp.app.admin.model.EventManage;
import com.sp.app.common.StorageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

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
            if(dto.getPhotoFiles() != null && !dto.getPhotoFiles().isEmpty()) {
            	MultipartFile file = dto.getPhotoFiles().get(0);
            	if(!file.isEmpty()) {
            		String originalFilename = file.getOriginalFilename();
            		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
            		String saveFilename = UUID.randomUUID().toString() + fileExt;
            		
            		File dir = new File(pathname);
            		if(!dir.exists()) {
            			dir.mkdirs();
            		}
            		
            		file.transferTo(new File(pathname, saveFilename));
            		
            		dto.setPhoto(saveFilename);
            	}
            }
            
            mapper.insertEvent(dto);
        } catch (Exception e) {
            log.error("insertEvent : ", e);
            throw e;
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
	
	@Transactional
	@Override
	public void updateEvent(EventManage dto, String pathname) throws Exception {
		
		try {
			if(dto.getPhotoFiles() != null && !dto.getPhotoFiles().isEmpty()) {
				MultipartFile file = dto.getPhotoFiles().get(0);
				if(!file.isEmpty()) {
					
					EventManage OldDto = readEvent(dto.getNum());
					if(OldDto.getPhoto() != null) {
						storageService.deleteFile(pathname, OldDto.getPhoto());
					}
					
					String saveFilename = storageService.uploadFileToServer(file, pathname);
					dto.setPhoto(saveFilename);
				}
			}
			
			mapper.updateEvent(dto);
		} catch (Exception e) {
			log.info("updateEvent : ", e);
			throw e;
		}
	}
	

	@Transactional
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

	@Override
	public void deleteCoupon(long num) throws Exception {
		// TODO Auto-generated method stub
	}
	
	
	
}
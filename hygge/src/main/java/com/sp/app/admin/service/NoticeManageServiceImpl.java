package com.sp.app.admin.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.mapper.NoticeManageMapper;
import com.sp.app.admin.model.NoticeManage;
import com.sp.app.common.FileManager;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class NoticeManageServiceImpl implements NoticeManageService{
	private final NoticeManageMapper mapper;
	private final FileManager fileManager;

	@Override
	public void insertNotice(NoticeManage dto, String pathname) throws Exception {
		
		try {
			fileManager.createAllDirectories(pathname);
			
			mapper.insertNotice(dto);
			
			// 첨부 파일 저장
			if(dto.getAttachFiles() != null) {
				for(MultipartFile file : dto.getAttachFiles()) {
					if(file.isEmpty()) {
						continue;
					}
					
					// 고유 파일명 생성
					String originalFilename = file.getOriginalFilename();
					File dest = new File(pathname, originalFilename);
					file.transferTo(dest);
							
					//파일 정보 db 저장
                    dto.setNoticeNum(dto.getNum()); // notice_num에 현재 게시글 번호 설정
                    dto.setSFileName(originalFilename);  // s_FileName에 저장된 파일명 설정
                    
					mapper.insertNoticeFile(dto);
				}
			}
			
		} catch (Exception e) {
			log.info("insertNotice : ", e);
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		return mapper.dataCount(map);
	}

	@Override
	public List<NoticeManage> listNotice(Map<String, Object> map) {
		return mapper.listNotice(map);
	}

	@Override
	public NoticeManage findById(long num) {
		return mapper.findById(num);
	}

	@Override
	public NoticeManage findByPrev(Map<String, Object> map) {
		return mapper.findByPrev(map);
	}

	@Override
	public NoticeManage findByNext(Map<String, Object> map) {
		return mapper.findByNext(map);
	}

	@Override
	public List<NoticeManage> listNoticeFile(long num) {
		return mapper.listNoticeFile(num);
	}

}

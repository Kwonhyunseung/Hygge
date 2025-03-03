package com.sp.app.admin.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
                    dto.setS_FileName(originalFilename);  // s_FileName에 저장된 파일명 설정
                    
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

    @Override
    public void updateNotice(NoticeManage dto, String pathname) {
    	
        try {
            // 게시글 내용 수정
            mapper.updateNotice(dto);
            
            // 파일 업로드가 있는 경우에만 처리
            if(dto.getAttachFiles() != null) {
                // 기존 파일 정보 가져오기
                List<NoticeManage> fileList = listNoticeFile(dto.getNum());
                
                // 디렉토리가 없으면 생성
                fileManager.createAllDirectories(pathname);
                
                // 기존 파일 삭제
                for(NoticeManage vo : fileList) {
                    // 실제 파일 삭제
                    fileManager.deletePath(pathname + File.separator + vo.getS_FileName());
                    // DB에서 파일 정보 삭제
                    mapper.deleteNoticeFile(vo.getNum());
                }
                
                // 새로운 파일 업로드
                for(MultipartFile file : dto.getAttachFiles()) {
                    if(file.isEmpty()) {
                        continue;
                    }
                    
                    // 원본 파일명
                    String originalFilename = file.getOriginalFilename();
                    // 파일 확장자
                    String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
                    // 서버에 저장할 새로운 파일명
                    String saveFilename = fileManager.generateUniqueFileName(pathname, extension);
                    
                    // 파일 업로드
                    File dest = new File(pathname, saveFilename);
                    file.transferTo(dest);
                    
                    dto.setNoticeNum(dto.getNum());
                    dto.setS_FileName(saveFilename);
                    mapper.insertNoticeFile(dto);
                }
            }
            
        } catch(Exception e) {
            log.info("updateNotice : ", e);
        }
    }

	@Override
	public void deleteNoticeFile(long num, String pathname) throws Exception {
	    try {
	        NoticeManage dto = mapper.findById(num);
	        if(dto == null) {
	            return;
	        }
	        
	        List<NoticeManage> listFile = listNoticeFile(num);
	        
	        for(NoticeManage vo : listFile) {
	            fileManager.deletePath(pathname + File.separator + vo.getS_FileName());
	            
	            mapper.deleteNoticeFile(vo.getNum());
	        }
	        
	    } catch(Exception e) {
	        log.error("deleteNoticeFile error", e);
	        throw e;
	    }		
	}
	@Override
	public void deleteNotice(long num, String pathname) throws Exception {
	    try {
	        List<NoticeManage> fileList = listNoticeFile(num);
	        
	        for(NoticeManage vo : fileList) {
	            fileManager.deletePath(pathname + File.separator + vo.getS_FileName());
	        }
	        
	        mapper.deleteAllNoticeFiles(num);
	        
	        mapper.deleteNotice(num);
	        
	    } catch(Exception e) {
	        log.error("deleteNotice error", e);
	        throw e;
	    }
	}

	@Override
	@Transactional
	public void deleteNotices(List<Long> nums, String pathname) throws Exception {
	    try {
	        for (Long num : nums) {
	            List<NoticeManage> fileList = listNoticeFile(num);
	            
	            // 물리적 파일 삭제
	            for (NoticeManage vo : fileList) {
	                fileManager.deletePath(pathname + File.separator + vo.getS_FileName());
	            }
	            
	            // 해당 공지사항의 모든 파일 DB 레코드 삭제
	            mapper.deleteAllNoticeFiles(num);
	        }
	        
	        // 여러 공지사항 삭제
	        mapper.deleteNotices(nums);
	        
	    } catch (Exception e) {
	        log.error("deleteNotices error", e);
	        throw e;
	    }
	}
}

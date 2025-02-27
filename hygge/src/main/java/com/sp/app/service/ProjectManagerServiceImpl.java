package com.sp.app.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.ProjectManagerMapper;
import com.sp.app.model.ProjectManager;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProjectManagerServiceImpl implements ProjectManagerService {
    
    @Autowired
    private final ProjectManagerMapper mapper;
    private final StorageService storageService;
    
    
    @Override
    public List<ProjectManager> listProject(Map<String, Object> map) {
        List<ProjectManager> list = null;
        try {
            list = mapper.listProject(map);
        } catch (Exception e) {
            log.error("리스트 조회 실패: ", e);
        }    
        return list;
    }

    @Override
    public int dataCount(Map<String, Object> map) {
        int result = 0;
        try {
            result = mapper.dataCount(map);
        } catch (Exception e) {
            log.error("dataCount 실패: ", e);
        }
        return result;
    }

    @Override
    public ProjectManager findById(String id) throws SQLException {
        ProjectManager dto = null;
        try {
            dto = mapper.findById(id);
        } catch (Exception e) {
            log.error("findById 실패: ", e);
        }
        return dto;
    }

    @Override
    public List<ProjectManager> listboard(Map<String, Object> map) {
        List<ProjectManager> list = null;
        try {
            list = mapper.listboard(map);
        } catch (Exception e) {
            log.error("리스트 조회 실패: ", e);
        }    
        return list;    
    }

    @Override
    public int b_dataCount(Map<String, Object> map) {
        int result = 0;
        try {
            result = mapper.b_dataCount(map);
        } catch (Exception e) {
            log.error("b_dataCount 실패: ", e);
        }
        return result;
    }

    @Override
    public void insertBoard(ProjectManager dto,String uploadPath) throws SQLException {
        try {
        	long seq = mapper.makerBoardSeq();
            // 1. 게시글 삽입
        	dto.setMkboard_Num(seq);
            mapper.insertBoard(dto);
            if(! dto.getSelectFile().isEmpty()) {
            	for (MultipartFile selectFile : dto.getSelectFile()) {
            		String saveFilename = storageService.uploadFileToServer(selectFile, uploadPath);
            		System.out.println(saveFilename);
            		Map<String, Object> map = new HashMap<String, Object>();
            		map.put("mkboard_Num", seq);
            		map.put("sfileName", saveFilename);
            		mapper.insertFile(map);
            	}
            }
   
        } catch (Exception e) {
            log.error("insertBoard 실패: ", e);
            
            throw e;
        }
    }

    @Override
    public void updateBoard(ProjectManager dto, String uploadPath) throws Exception {
    		
    	try {
    		if(dto.getSelectFile() != null && ! dto.getSelectFile().isEmpty()) {
    			if(! dto.getSelectFile().isEmpty()) {
					deleteUploadFile(uploadPath, dto.getSfileName());
					
				}
    			for(MultipartFile selectFile : dto.getSelectFile()) {
    			String saveFilename = storageService.uploadFileToServer(
    					selectFile, uploadPath);
				dto.setSfileName(saveFilename);
				
				// 박재민 병신아 map을 비워놓으면 안돼 
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("mkboard_Num", dto.getMkboard_Num());
				map.put("sfileName", dto.getSfileName());
				
				
				mapper.insertFile(map);
				
    			}
    		}
    		mapper.updateBoard(dto);
    		
		} catch (Exception e) {
			log.info("updateBoard : ", e);
			
			throw e;
		}
		
   
    
    }

    @Override
    public void deleteBoard(String uploadPath, long mkboard_Num) throws Exception {
        
        try {
        	List<ProjectManager> listFile = listFile(mkboard_Num);
        	Map<String, Object> map = new HashMap<>();
        	map.put("mkboard_Num", mkboard_Num);
        	if(listFile.size() == 0) {
        		for(ProjectManager dto : listFile) {
        			deleteUploadFile(uploadPath, dto.getSfileName());
        		}
        		mapper.deleteFile(map);
        	}
        	
        	//파일 테이블 내용 시우기 
        	mapper.deleteBoard(mkboard_Num);
        } catch (Exception e) {
            log.error("deleteBoard 실패: ", e);
            
            throw e;
        }
    }

	@Override
	public void insertFile(ProjectManager dto,String uploadPath) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ProjectManager> listFile(long mkboard_Num) {
		List<ProjectManager> listFile = null;
		
		try {
			listFile = mapper.listFile(mkboard_Num);
		} catch (Exception e) {
			log.info("listFile : ", e);
		}
		
		return listFile;
	}

	@Override
	public ProjectManager findByFileId(long fileNum) {
		ProjectManager dto = null;
		try {
			dto = mapper.findByFileId(fileNum);
		} catch (Exception e) {
			log.info("findByFileId : ", e);
		}
		
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteFile(map);
		} catch (Exception e) {
			log.info("deleteFile : ", e);
			
			throw e;
		}
		
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}

	@Override
	public void updateFile(ProjectManager dto, String uploadPath) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ProjectManager findById(long mkboard_Num) {
		ProjectManager dto = null;
		
		try {
			dto = mapper.findById(mkboard_Num);
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}
}

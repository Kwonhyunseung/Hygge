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
    public void updateBoard(ProjectManager dto,String uploadPath) throws SQLException {
        // 게시글 수정 로직 구현
        try {
            mapper.updateBoard(dto); // 업데이트 메서드 호출
        } catch (Exception e) {
            log.error("updateBoard 실패: ", e);
        }
    }

    @Override
    public void deleteBoard(ProjectManager dto) throws SQLException {
        // 게시글 삭제 로직 구현
        try {
            mapper.deleteBoard(dto); // 삭제 메서드 호출
        } catch (Exception e) {
            log.error("deleteBoard 실패: ", e);
        }
    }

	@Override
	public void insertFile(ProjectManager dto,String uploadPath) throws SQLException {
		// TODO Auto-generated method stub
		
	}
}

package com.sp.app.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.MyPageMapper;
import com.sp.app.model.MyPage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyPageServiceImpl implements MyPageService {
    private final MyPageMapper mapper;
    
    private final StorageService storageService;
    
    @Override
    public MyPage findById(String id) {
        MyPage dto = null;
        try {
            dto = mapper.findById(id);
        } catch (Exception e) {
            log.error("findById failed: ", e);
        }
        return dto;
    }

    @Override
    public void ProfileEdit(MyPage dto,String uploadPath2) {
        try {
        	
        	System.out.println("프로필 수정 진입");
        	
        	 mapper.ProfileEdit(dto);
        	
        	if (dto.getProfileImg_File() != null && !dto.getProfileImg_File().isEmpty()) {
				dto.setProfile_img(storageService.uploadFileToServer(dto.getProfileImg_File(), uploadPath2));
				System.out.println("프로필 파일 업로드");
        	}
        	
			Map<String, Object> map = new HashMap<>();
			map.put("profile_img", dto.getProfile_img());
			map.put("id", dto.getId());
			System.out.println("put 됨");
			mapper.updateProfile(map);
			System.out.println("프로필 사진 성공");
           
            
            System.out.println("프로필 수정 성공");
        } catch (Exception e) {
            log.error("ProfileEdit failed: ", e);
        }
    }
    @Transactional
    @Override
    public void ProfileEdit2(MyPage dto) {
        try {
             mapper.ProfileEdit2(dto);
        } catch (Exception e) {
            log.error("ProfileEdit2 failed: ", e);
        }
    }


	@Override
	public void updateProfile(MyPage dto, String uploadPath2) throws Exception {
	      try {
	            ProfileEdit(dto,uploadPath2);

	            ProfileEdit2(dto);
	        } catch (Exception e) {
	            log.error("Profile update failed: ", e);
	            throw e;
	        }
		
	}

}

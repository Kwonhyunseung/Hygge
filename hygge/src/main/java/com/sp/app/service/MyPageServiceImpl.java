package com.sp.app.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.mapper.MyPageMapper;
import com.sp.app.model.MyPage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyPageServiceImpl implements MyPageService {
    private final MyPageMapper mapper;
    
    
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
    public void ProfileEdit(MyPage dto) {
        try {
             mapper.ProfileEdit(dto);
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

    @Transactional
    @Override
    public void updateProfile(MyPage dto) {
        try {
            ProfileEdit(dto);

            ProfileEdit2(dto);
        } catch (Exception e) {
            log.error("Profile update failed: ", e);
            throw e;
        }
    }

}

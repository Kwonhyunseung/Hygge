package com.sp.app.service;

import com.sp.app.model.MyPage;

public interface MyPageService {
    public MyPage findById(String id)throws Exception;
    public void ProfileEdit(MyPage dto,String uploadPath2)throws Exception;
    public void ProfileEdit2(MyPage dto)throws Exception;
    public void updateProfile(MyPage dto,String uploadPath2)throws Exception;
    

}
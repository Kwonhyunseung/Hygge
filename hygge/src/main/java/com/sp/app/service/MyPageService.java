package com.sp.app.service;

import com.sp.app.model.MyPage;

public interface MyPageService {
    public MyPage findById(String id);
    public void ProfileEdit(MyPage dto);
    public void ProfileEdit2(MyPage dto);
    public void updateProfile(MyPage dto);

}
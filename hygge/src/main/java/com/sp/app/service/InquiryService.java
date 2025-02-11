package com.sp.app.service;

import com.sp.app.model.Inquiry;
import java.util.List;
import java.util.Map;

public interface InquiryService {

    // 문의 글 삽입
    void insertInquiry(Inquiry dto) throws Exception;

    // 데이터 개수 조회
    int dataCount(Map<String, Object> map);

    // 문의 글 목록 조회
    List<Inquiry> listInquiry(Map<String, Object> map);

    // 특정 문의 글 조회
    Inquiry findById(long num);

    // 이전 문의 글 조회
    Inquiry findByPrev(Map<String, Object> map);

    // 다음 문의 글 조회
    Inquiry findByNext(Map<String, Object> map);

    // 문의 글 수정
    void updateInquiry(Inquiry dto) throws Exception;

    // 문의 글 삭제
    void deleteInquiry(long num) throws Exception;
}

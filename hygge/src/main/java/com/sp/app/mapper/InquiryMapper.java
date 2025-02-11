package com.sp.app.mapper;

import com.sp.app.model.Inquiry;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface InquiryMapper {

    // 문의 글 삽입
    void insertInquiry(Inquiry inquiry);

    // 문의 글 목록 조회
    List<Inquiry> listInquiry(Map<String, Object> params);

    // 특정 문의 글 조회
    Inquiry selectInquiry(long num);

    // 이전 문의 글 조회
    Inquiry selectPrevInquiry(Map<String, Object> params);

    // 다음 문의 글 조회
    Inquiry selectNextInquiry(Map<String, Object> params);

    // 문의 글 수정
    void updateInquiry(Inquiry inquiry);

    // 문의 글 삭제
    void deleteInquiry(long num);

	int dataCount(Map<String, Object> map);
}

package com.sp.app.service;

import com.sp.app.model.Qna;
import java.util.List;
import java.util.Map;

public interface QnaService {

    // 문의 글 삽입
    void insertQna(Qna dto) throws Exception;

    // 데이터 개수 조회
    int dataCount(Map<String, Object> map);

    // 문의 글 목록 조회
    List<Qna> listQna(Map<String, Object> map);

    // 특정 문의 글 조회
    Qna findById(long num);

    // 이전 문의 글 조회
    Qna findByPrev(Map<String, Object> map);

    // 다음 문의 글 조회
    Qna findByNext(Map<String, Object> map);

    // 문의 글 수정
    void updateQna(Qna dto) throws Exception;

    // 문의 글 삭제
    void deleteQna(long num) throws Exception;
}

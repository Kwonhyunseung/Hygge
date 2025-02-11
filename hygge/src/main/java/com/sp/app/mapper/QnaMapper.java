package com.sp.app.mapper;

import com.sp.app.model.Qna;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QnaMapper {

    // 문의 글 삽입
    void insertQna(Qna Qna);

    // 문의 글 목록 조회
    List<Qna> listQna(Map<String, Object> params);

    // 특정 문의 글 조회
    Qna selectQna(long num);

    // 이전 문의 글 조회
    Qna selectPrevQna(Map<String, Object> params);

    // 다음 문의 글 조회
    Qna selectNextQna(Map<String, Object> params);

    // 문의 글 수정
    void updateQna(Qna Qna);

    // 문의 글 삭제
    void deleteQna(long num);

	int dataCount(Map<String, Object> map);
}

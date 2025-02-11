package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.InquiryMapper;
import com.sp.app.model.Inquiry;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class InquiryServiceImpl implements InquiryService {

    private final InquiryMapper inquiryMapper; // InquiryMapper를 주입받음

    @Override
    public void insertInquiry(Inquiry dto) throws Exception {
        try {
            // 문의 글을 DB에 저장
            inquiryMapper.insertInquiry(dto);
        } catch (Exception e) {
            log.error("insertInquiry failed", e);
            throw e; // 예외 발생 시 상위로 던짐
        }
    }

    @Override
    public int dataCount(Map<String, Object> map) {
        try {
            // 조회 조건에 맞는 데이터 개수 반환
            return inquiryMapper.dataCount(map);
        } catch (Exception e) {
            log.error("dataCount failed", e);
            return 0; // 오류 발생 시 0을 반환
        }
    }

    @Override
    public List<Inquiry> listInquiry(Map<String, Object> map) {
        try {
            // 조건에 맞는 문의 글 목록 조회
            return inquiryMapper.listInquiry(map);
        } catch (Exception e) {
            log.error("listInquiry failed", e);
            return null; // 오류 발생 시 null 반환
        }
    }

    @Override
    public Inquiry findById(long num) {
        try {
            // 특정 문의 글 조회
            return inquiryMapper.selectInquiry(num);
        } catch (Exception e) {
            log.error("findById failed", e);
            return null; // 오류 발생 시 null 반환
        }
    }

    @Override
    public Inquiry findByPrev(Map<String, Object> map) {
        try {
            // 이전 문의 글 조회
            return inquiryMapper.selectPrevInquiry(map);
        } catch (Exception e) {
            log.error("findByPrev failed", e);
            return null; // 오류 발생 시 null 반환
        }
    }

    @Override
    public Inquiry findByNext(Map<String, Object> map) {
        try {
            // 다음 문의 글 조회
            return inquiryMapper.selectNextInquiry(map);
        } catch (Exception e) {
            log.error("findByNext failed", e);
            return null; // 오류 발생 시 null 반환
        }
    }

    @Override
    public void updateInquiry(Inquiry dto) throws Exception {
        try {
            // 문의 글 업데이트
            inquiryMapper.updateInquiry(dto);
        } catch (Exception e) {
            log.error("updateInquiry failed", e);
            throw e; // 예외 발생 시 상위로 던짐
        }
    }

    @Override
    public void deleteInquiry(long num) throws Exception {
        try {
            // 문의 글 삭제
            inquiryMapper.deleteInquiry(num);
        } catch (Exception e) {
            log.error("deleteInquiry failed", e);
            throw e; // 예외 발생 시 상위로 던짐
        }
    }
}

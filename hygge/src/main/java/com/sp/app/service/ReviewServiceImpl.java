package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ReviewMapper;
import com.sp.app.model.Review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReviewServiceImpl implements ReviewService {
    private final ReviewMapper mapper;

    @Override
    public void insertReview(Review dto) throws SQLException {
        // 리뷰 추가 로직은 추후 작성
    }

    @Override
    public List<Review> reviewList(Map<String, Object> map) {
    	List<Review> list = null;
        try {
           list = mapper.reviewList(map);
        } catch (Exception e) {
            log.error("리스트 조회 실패", e);
          
        }
        return list;
    }

    @Override
    public Review findById(long num) {
        try {
            return mapper.findById(num);  // Mapper에서 findById 쿼리 호출
        } catch (Exception e) {
            log.error("리뷰 조회 실패", e);
            return null;
        }
    }

    @Override
    public int reviewCount(long memberIdx) {
        try {
            return mapper.reviewCount(memberIdx); // Mapper에서 reviewCount 쿼리 호출
        } catch (Exception e) {
            log.error("리뷰 개수 조회 실패", e);
            return 0;
        }
    }

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void deleteReview(long num) throws Exception {
		try {
			mapper.deleteReview(num);
		} catch (Exception e) {
			log.info("deleteReview : ", e);
		}
	}
}

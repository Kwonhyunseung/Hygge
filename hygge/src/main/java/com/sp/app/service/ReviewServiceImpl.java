package com.sp.app.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.ReviewMapper;
import com.sp.app.model.Review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReviewServiceImpl implements ReviewService {
    private final ReviewMapper mapper;
    private final StorageService storageService;
    
    
    @Override
    public void insertReview(Review dto,String uploadPath) throws SQLException {
        try {
        	long seq = mapper.reviewSeq();
        	dto.setReview_num(seq);
        	mapper.insertReview(dto);
        	if(! dto.getSelectFile().isEmpty()) {
        	for(MultipartFile selectFile : dto.getSelectFile()) {
        		String saveFilename = storageService.uploadFileToServer(selectFile, uploadPath);
        		Map<String, Object> map = new HashMap<String, Object>();
        		map.put("review_num", seq);
        		map.put("sfileName", saveFilename);
        		mapper.insertFile(map);
        	}
        	}
			
		} catch (Exception e) {
	log.info("insertReview : ", e);
			
			throw e;
		}
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

	@Override
	public void insertFile(Review dto, String uploadPath) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Review> listFile(long num) {
			List<Review> listFile = null;
		
		try {
			listFile = mapper.listFile(num);
		} catch (Exception e) {
			log.info("listFile : ", e);
		}
		
		return listFile;
	}
}

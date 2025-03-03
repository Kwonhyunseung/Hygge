package com.sp.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.FundingProjectMapper;
import com.sp.app.mapper.HomeMapper;
import com.sp.app.model.Category;
import com.sp.app.model.Funding;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class HomeServiceImpl implements HomeService {
	private final HomeMapper mapper;
	private final FundingProjectMapper projectMapper;
	/* private final FundingProjectServiceImpl service; */

	@Override
	public List<Category> subListCategory(long parent_num) {
		List<Category> list = null;

		try {
			list = mapper.subListCategory(parent_num);
		} catch (Exception e) {
			log.info("subListCategory: ", e);
		}
		return list;

	}
	
	@Override
	public List<Funding> listNewProjects(Map<String, Object> map) {
		List<Funding> list = null;

		try {
			list = mapper.listNewProjects(map);
			
			// 모든 프로젝트 메소드에 이 코드 적용
			for (Funding project : list) {
			    // 초기값으로 무조건 좋아요 상태를 false로 설정
			    project.setUserLiked(false);
			    
			    // 로그인한 사용자의 좋아요 상태 개별 확인
			    if (map.containsKey("memberIdx")) {
			        Long memberIdx = (Long) map.get("memberIdx");
			        
			        // 개별 프로젝트에 대한 좋아요 확인을 위한 맵
			        Map<String, Object> likeMap = new HashMap<>();
			        likeMap.put("num", project.getNum());
			        likeMap.put("memberIdx", memberIdx);
			        
			        // 좋아요 여부 확인 - 명시적으로 boolean으로 변환
			        int likeCount = projectMapper.userFundingLiked(likeMap);
			        project.setUserLiked(likeCount > 0);
			        
			        // 디버깅 로그 추가
			        log.info("프로젝트 번호: " + project.getNum() + ", 사용자: " + memberIdx + ", 좋아요 상태: " + (likeCount > 0));
			    }
			}
			
		} catch (Exception e) {
			log.info("listNewProjects: ", e);
		}

		return list;
	}

	@Override
    public List<Funding> listPopularProjects(Map<String, Object> map) {
        List<Funding> list = null;

        try {
            list = mapper.listPopularProjects(map);

         // 모든 프로젝트 메소드에 이 코드 적용
            for (Funding project : list) {
                // 초기값으로 무조건 좋아요 상태를 false로 설정
                project.setUserLiked(false);
                
                // 로그인한 사용자의 좋아요 상태 개별 확인
                if (map.containsKey("memberIdx")) {
                    Long memberIdx = (Long) map.get("memberIdx");
                    
                    // 개별 프로젝트에 대한 좋아요 확인을 위한 맵
                    Map<String, Object> likeMap = new HashMap<>();
                    likeMap.put("num", project.getNum());
                    likeMap.put("memberIdx", memberIdx);
                    
                    // 좋아요 여부 확인 - 명시적으로 boolean으로 변환
                    int likeCount = projectMapper.userFundingLiked(likeMap);
                    project.setUserLiked(likeCount > 0);
                    
                    // 디버깅 로그 추가
                    log.info("프로젝트 번호: " + project.getNum() + ", 사용자: " + memberIdx + ", 좋아요 상태: " + (likeCount > 0));
                }
            }

        } catch (Exception e) {
            log.info("listPopularProjects: ", e);
        }

        return list;
    }

	@Override
    public List<Funding> listDeadlineProjects(Map<String, Object> map) {
        List<Funding> list = null;

        try {
            list = mapper.listDeadlineProjects(map);

         // 모든 프로젝트 메소드에 이 코드 적용
            for (Funding project : list) {
                // 초기값으로 무조건 좋아요 상태를 false로 설정
                project.setUserLiked(false);
                
                // 로그인한 사용자의 좋아요 상태 개별 확인
                if (map.containsKey("memberIdx")) {
                    Long memberIdx = (Long) map.get("memberIdx");
                    
                    // 개별 프로젝트에 대한 좋아요 확인을 위한 맵
                    Map<String, Object> likeMap = new HashMap<>();
                    likeMap.put("num", project.getNum());
                    likeMap.put("memberIdx", memberIdx);
                    
                    // 좋아요 여부 확인 - 명시적으로 boolean으로 변환
                    int likeCount = projectMapper.userFundingLiked(likeMap);
                    project.setUserLiked(likeCount > 0);
                    
                    // 디버깅 로그 추가
                    log.info("프로젝트 번호: " + project.getNum() + ", 사용자: " + memberIdx + ", 좋아요 상태: " + (likeCount > 0));
                }
            }

        } catch (Exception e) {
            log.info("listDeadlineProjects: ", e);
        }

        return list;
    }

	@Override
	public List<Funding> listComingProjects(Map<String, Object> map) {
		List<Funding> list = null;

		try {
			list = mapper.listComingProjects(map);
			
		} catch (Exception e) {
			log.info("listComingProjects: ", e);
		}

		return list;
	}

	@Override
	public List<Funding> listRankingProjects(Map<String, Object> map) {
		List<Funding> list = null;

		try {
			list = mapper.listRankingProjects(map);
			
		} catch (Exception e) {
			log.info("listRankingProjects: ", e);
		}

		return list;
	}

}
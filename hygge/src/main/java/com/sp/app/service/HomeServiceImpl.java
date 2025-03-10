package com.sp.app.service;

import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.FundingMainMapper;
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
	private final FundingMainMapper mainmapper;
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
			
			for (Funding project : list) {
			    project.setUserLiked(false); //좋아요 초기값
			    
			    if (map.containsKey("memberIdx")) {
			        Long memberIdx = (Long) map.get("memberIdx");
			        
			        Map<String, Object> likeMap = new HashMap<>();
			        likeMap.put("num", project.getNum());
			        likeMap.put("memberIdx", memberIdx);
			        
			        int likeCount = projectMapper.userFundingLiked(likeMap);
			        project.setUserLiked(likeCount > 0);
			        
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

            for (Funding project : list) {
                project.setUserLiked(false);
                
                if (map.containsKey("memberIdx")) {
                    Long memberIdx = (Long) map.get("memberIdx");
                    
                    Map<String, Object> likeMap = new HashMap<>();
                    likeMap.put("num", project.getNum());
                    likeMap.put("memberIdx", memberIdx);
                    
                    int likeCount = projectMapper.userFundingLiked(likeMap);
                    project.setUserLiked(likeCount > 0);
                    
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

            for (Funding project : list) {
                project.setUserLiked(false);
                
                if (map.containsKey("memberIdx")) {
                    Long memberIdx = (Long) map.get("memberIdx");
                    
                    Map<String, Object> likeMap = new HashMap<>();
                    likeMap.put("num", project.getNum());
                    likeMap.put("memberIdx", memberIdx);
                    
                    int likeCount = projectMapper.userFundingLiked(likeMap);
                    project.setUserLiked(likeCount > 0);
                    
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

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.searchDataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}

	@Override
	public List<Funding> listFunding(Map<String, Object> map) {
		List<Funding> list = null;
		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.KOREA);
		try {
			list = mapper.listSearchFunding(map);
			for (Funding dto : list) {
				dto.setFunding_goal(numberFormat.format(dto.getTotal_amount()));
				dto.setProgress((int)((float)dto.getTotal_amount() / (float)dto.getTarget() * 100));
			}
			if (map.get("memberIdx") == null) {
				return list;
			}
			for (Funding dto : list) {
				map.put("num", dto.getNum());
				if (mainmapper.isUserLiked(map) != 0) {
					dto.setUserLiked(true);
				} else {
					dto.setUserLiked(false);
				}
			}
		} catch (Exception e) {
			log.info("listFunding : ", e);
		}
		return list;
	}

}
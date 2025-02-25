package com.sp.app.service;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.mapper.FundingProjectMapper;
import com.sp.app.model.Funding;
import com.sp.app.model.Product;
import com.sp.app.model.Review;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FundingProjectServiceImpl implements FundingProjectService {
	private final FundingProjectMapper mapper;
	private final MyUtil myUtil;

	@Override
	public Funding fundingProduct(long num) {
		Funding dto = null;
		
		try {
			dto = mapper.fundingProduct(num);
		} catch (Exception e) {
			log.info("fundingProduct: ", e);
		}
		
		return dto;
	}
	
	public void calculateProject(Funding project) {
        // 펀딩 달성률
        double fundingGoal = (double) project.getTotal_amount() / project.getTarget() * 100;
        project.setFunding_goal(String.format("%.0f", fundingGoal)); // 소수점 없이 반올림

        try {
            LocalDate inputDate = parseDate(project.getEnd_date());

            // 남은 기간 계산
            long daysBetween = ChronoUnit.DAYS.between(LocalDate.now(), inputDate);
            project.setRemained_date(String.valueOf(Math.max(0, daysBetween))); // 음수 방지

            // 결제일 계산
            project.setPayment_date(inputDate.plusDays(1).format(DateTimeFormatter.ofPattern("yyyy.MM.dd")));
        } catch (Exception e) {
            // 에러시 기본값
            project.setRemained_date("0");
            project.setPayment_date(LocalDate.now().plusDays(1).format(DateTimeFormatter.ofPattern("yyyy.MM.dd")));
        }
    }

	// 날짜 파싱
    private static LocalDate parseDate(String dateString) {
        try {
            // 숫자만 있는 경우 (예: "20240312")
            if (dateString.matches("\\d{8}")) {
                return LocalDate.parse(dateString.substring(0, 4) + "-" + dateString.substring(4, 6) + "-"
                        + dateString.substring(6, 8), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            }

            // 하이픈, 점, 슬래시 형식 변환
            String normalizedDate = dateString.replace(".", "-").replace("/", "-");

            if (normalizedDate.matches("\\d{4}-\\d{2}-\\d{2}")) {
                return LocalDate.parse(normalizedDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            }

            DateTimeFormatter[] formatters = {
                    DateTimeFormatter.ofPattern("yyyy-MM-dd"),
                    DateTimeFormatter.ofPattern("yyyy.MM.dd"),
                    DateTimeFormatter.ofPattern("yyyy/MM/dd"),
                    DateTimeFormatter.ofPattern("yyyyMMdd"),
                    DateTimeFormatter.ofPattern("dd-MM-yyyy"),
                    DateTimeFormatter.ofPattern("MM/dd/yyyy")
            };

            for (DateTimeFormatter fmt : formatters) {
                try {
                    return LocalDate.parse(dateString, fmt);
                } catch (Exception e) {
                    // 이 형식으로 파싱 불가능하면 다음 형식 시도
                    continue;
                }
            }

            // 모든 형식이 실패하면 현재 날짜 반환
            return LocalDate.now();
        } catch (Exception e) {
            return LocalDate.now();
        }
    }

	// 숫자 포맷팅
    public String convertToString(Double input) {
        if (input == null) return "0.00";
        return new DecimalFormat("#,##0.00").format(input);
    }

	@Override
	public List<Product> detailProduct(Map<String, Object> map) {
		List<Product> list = null;
		
		try {
			list = mapper.detailProduct(map);
		} catch (Exception e) {
			log.info("detailProduct: ", e);
		}
		
		return list;
	}
	
	@Override
	public int projectLikeCount(long num) {
		int result = 0;
		try {
			result = mapper.projectLikeCount(num);
		} catch (Exception e) {
			log.info("projectLikeCount: ", e);
		}
		return result;
	}

	@Override
	public void insertProjectLikeCount(Map<String, Object> map) {
		try {
			mapper.insertProjectLikeCount(map);
		} catch (Exception e) {
			log.info("insertProjectLikeCount: ", e);
		}
	}

	@Override
	public void deleteProjectLikeCount(Map<String, Object> map) {
		try {
			mapper.deleteProjectLikeCount(map);
		} catch (Exception e) {
			log.info("deleteProjectLikeCount: ", e);
		}
		
	}

	@Override
	public int userFundingLiked(Map<String, Object> map) {
	    int result = 0;
	    try {
	        result = mapper.userFundingLiked(map);
	    } catch (Exception e) {
	        log.info("userFundingLiked: ", e);
	    }
	    return result;
	}
	
	@Override
	public int userFollowing(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.userFollowing(map);
		} catch (Exception e) {
			log.info("isUserFollowing: ", e);
		}
		return result;
	}

	@Override
	public void insertFollowing(Map<String, Object> map) {
		try {
			mapper.insertFollowing(map);
		} catch (Exception e) {
			log.info("insertFollowing: ", e);
		}
	}

	@Override
	public void deleteFollowing(Map<String, Object> map) {
		try {
			mapper.deleteFollowing(map);
		} catch (Exception e) {
			log.info("deleteFollowing: ", e);
		}
		
	}
	

	
	
	@Override
	public List<Review> listProductReview(Map<String, Object> map) {
		List<Review> list = null;
		
		try {
			list = mapper.listProductReview(map);
			
			for(Review dto : list) {
				dto.setMemberName(myUtil.nameMasking(dto.getMemberName()));
				
				
			}
			
		} catch (Exception e) {
			log.info("listProductReview: ", e);
		}
		return list;
	}
	
	
}
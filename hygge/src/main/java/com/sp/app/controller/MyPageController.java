package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Coupon;
import com.sp.app.model.MyPage;
import com.sp.app.model.Payment;
import com.sp.app.model.Review;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.CouponService;
import com.sp.app.service.MyPageService;
import com.sp.app.service.PaymentService;
import com.sp.app.service.ReviewService; // ReviewService 추가
import com.sp.app.service.UsedBoardService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/myPage/*")
public class MyPageController {

    @Autowired
    private final MyPageService myPageService;

    @Autowired
    private final ReviewService reviewService;  // ReviewService 주입
    
    @Autowired
    private final UsedBoardService usedBoardService; //UsedBoardService 주입
    
    @Autowired
    private final CouponService couponService; // CouponService 주입
    
    @Autowired
    private final PaymentService paymentService; //PaymentService 주입
    
    @Autowired
    private final PaginateUtil paginateUtil;
    
    @GetMapping("myPage")
    public String myPage(Model model, HttpSession session) {
        try {
        	SessionInfo info = (SessionInfo)session.getAttribute("member");
            log.info("마이페이지 요청");

            // 프로필 정보 조회
            MyPage myPage = myPageService.findById(info.getId());
            model.addAttribute("myPage", myPage);
            
            // 리뷰 카운트 조회
            int reviewCount = reviewService.reviewCount(info.getMemberidx());  // 리뷰 카운트 조회
            model.addAttribute("reviewCount", reviewCount);  // 리뷰 카운트를 모델에 추가
          
            // 중고게시판 카운트 조회
            int boardCount = usedBoardService.BoardCount(info.getMemberidx());
            model.addAttribute("boardCount", boardCount);
            
            // 쿠폰 개수 조회
            int couponCount = couponService.couponCount(info.getMemberidx());
            model.addAttribute("couponCount", couponCount);
            

            
            
        } catch (Exception e) {
            log.error("마이페이지 오류", e);
        }
        return "myPage/myPage";
    }

    @GetMapping("profileEdit")
    public String profileEdit(HttpSession session, Model model) {
        try {
        	SessionInfo info = (SessionInfo)session.getAttribute("member");
            log.info("프로필 수정 페이지 요청");

            // 프로필 정보 조회
            MyPage myPage = myPageService.findById(info.getId());
            model.addAttribute("myPage", myPage);

        } catch (Exception e) {
            log.error("프로필 수정 페이지 오류", e);
        }
        return "myPage/profileEdit";
    }
    
    @PostMapping("profileEdit")
    public String updateProfile(MyPage myPage, HttpSession session, Model model, RedirectAttributes rttr) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            log.info("프로필 수정 요청: {}", myPage);

            myPage.setId(info.getId());

            myPageService.updateProfile(myPage);

            rttr.addFlashAttribute("msg", "프로필이 수정되었습니다.");
            return "redirect:/myPage/myPage";

        } catch (Exception e) {
            log.error("프로필 수정 오류", e);
            model.addAttribute("msg", "프로필 수정에 실패했습니다.");
            model.addAttribute("myPage", myPage);
            return "myPage/profileEdit"; 
        }
    }

    @GetMapping("buyHistory")
    public String buyHistory(Model model,
    		@RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            HttpSession session,
            HttpServletRequest req) {
    	
    	SessionInfo info = (SessionInfo)session.getAttribute("member");
    	
    	
        try {
            log.info("구매내역 페이지 요청");
            
            int size = 10;
            int total_page;
            int dataCount;
            
            // 검색도 만들려나..?
            kwd = URLDecoder.decode(kwd, "UTF-8");
            
            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("memberIdx", info.getMemberidx());
            
            dataCount = paymentService.dataCount(map);
            total_page = paginateUtil.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);
            
            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;
            
            map.put("offset", offset);
            map.put("size", size);
            
            List<Payment> paymentList = paymentService.paymentList(map);
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/myPage/paymentList";
            if (!kwd.isBlank()) {
                query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
                listUrl = cp + "/myPage/paymentList?" + query;
            }
            
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            System.out.println(dataCount+", "+current_page+", "+size);
            // 모델에 데이터 담기 (목록은 qnaList, 상세 링크는 articleUrl 등)
            model.addAttribute("paymentList", paymentList);
            //model.addAttribute("articleUrl", articleUrl);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            
            
        } catch (Exception e) {
            log.error("구매내역 페이지 오류", e);
        }
        return "myPage/buyHistory";
    }

    @GetMapping("couponList")
    public String couponList(Model model,
    		@RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            HttpSession session,
            HttpServletRequest req) {
    	
    	SessionInfo info = (SessionInfo)session.getAttribute("member");
    	
        try {
            log.info("쿠폰 페이지 요청");
            
            int size = 10;
            int total_page;
            int dataCount;
            
            // 검색도 만들려나..?
            kwd = URLDecoder.decode(kwd, "UTF-8");
            
            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("memberIdx", info.getMemberidx());
            
            dataCount = couponService.dataCount(map);
            total_page = paginateUtil.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);
            
            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;
            
            map.put("offset", offset);
            map.put("size", size);
            
            List<Coupon> listCoupon = couponService.listCoupon(map);
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/myPage/couponList";
            if (!kwd.isBlank()) {
                query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
                listUrl = cp + "/myPage/couponList?" + query;
            }
            
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            System.out.println(dataCount+", "+current_page+", "+size);
            // 모델에 데이터 담기 (목록은 qnaList, 상세 링크는 articleUrl 등)
            model.addAttribute("listCoupon", listCoupon);
            //model.addAttribute("articleUrl", articleUrl);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            
            
        } catch (Exception e) {
            log.error("쿠폰 페이지 오류", e);
            model.addAttribute("error", "쿠폰 페이지 리스트 조회 오류");
        }
        return "myPage/couponList";
    }

    @GetMapping("review")
    public String review(Model model,
    		@RequestParam(name = "page", defaultValue = "1") int current_page,
            @RequestParam(name = "schType", defaultValue = "all") String schType,
            @RequestParam(name = "kwd", defaultValue = "") String kwd,
            HttpSession session,
            HttpServletRequest req) {
    	
    	SessionInfo info = (SessionInfo)session.getAttribute("member");
    	
    	
        try {
            log.info("리뷰페이지리스트 요청");
            
            int size = 10;
            int total_page;
            int dataCount;
            
            // 검색도 만들려나..?
            kwd = URLDecoder.decode(kwd, "UTF-8");
            
            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);
            map.put("memberIdx", info.getMemberidx());
            
            dataCount = reviewService.dataCount(map);
            total_page = paginateUtil.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);
            
            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;
            
            map.put("offset", offset);
            map.put("size", size);
            
            List<Review> reviewList = reviewService.reviewList(map);
            String cp = req.getContextPath();
            String query = "";
            String listUrl = cp + "/myPage/review";
            if (!kwd.isBlank()) {
                query = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");
                listUrl = cp + "/myPage/review?" + query;
            }
            
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            System.out.println(dataCount+", "+current_page+", "+size);
            // 모델에 데이터 담기 (목록은 qnaList, 상세 링크는 articleUrl 등)
            model.addAttribute("reviewList", reviewList);
            //model.addAttribute("articleUrl", articleUrl);
            model.addAttribute("page", current_page);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);
            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);
            
        } catch (Exception e) {
            log.error("리뷰 페이지 오류", e);
        }
        return "myPage/review";
    }


    @GetMapping("chat")
    public String chat(Model model) {
        try {
            log.info("채팅 요청");
        } catch (Exception e) {
            log.error("채팅 오류", e);
        }
        return "myPage/chat";
    }
}

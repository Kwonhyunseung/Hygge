package com.sp.app.admin.model;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class PaymentManage {
    private long payment_num;       // 결제번호
    private long memberIdx;         // 회원 번호
    private String nickname;        // 구매자 닉네임
    private Date payment_date;      // 결제일
    private long total_amount;      // 총 금액
    private long pay_amount;        // 실 결제금액
    private long shipping_fee;      // 배송비
    private long coupon;            // 쿠폰할인금액
    private int pay_way;            // 결제수단
    private int sort;               // 결제 종류 (0: 프로젝트, 1: 중고장터)
    private int shipping_state;     // 배송상태
    
    // 상품 정보
    private long product_num;       // 상품번호
    private String title;           // 상품명
    private String origin;          // 원산지
    private int amount;             // 구매수량
    private long sum;               // 상품별 결제금액
}

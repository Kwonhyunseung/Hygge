package com.sp.app.model;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Payment {
	private Date payment_date;
    private String title;
    private int pay_amount;
    private String shipping_state;
}

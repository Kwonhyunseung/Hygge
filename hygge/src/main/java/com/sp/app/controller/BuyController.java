package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ch.qos.logback.core.model.Model;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/buy/*")
public class BuyController {
	
	// 결제창 - 상품 리스트
	/*
	@GetMapping("/productList/{num}")
	public String productList(@PathVariable("num") long num, Model model) {

		return "buy/productList";
	}
	*/
// 테스트용 ->실전은 위에껄로
@GetMapping("productList")
public String productList(Model model) {
	return "buy/productList";
}
	
	// 결제창 - 상품 선택
	/*
	@GetMapping("/productSelect/{num}")
	public String productSelect(@PathVariable("num") long num, Model model) {

		return "buy/productSelect";
	}
	*/
// 테스트용 ->실전은 위에껄로
@GetMapping("productChoice")
public String productSelect(Model model) {
	return "buy/productChoice";
}

	// 결제창 - 완료
	/*
	@GetMapping("/complete/{num}")
	public String complete(@PathVariable("num") long num, Model model) {

		return "buy/complete";
	}
	*/
// 테스트용 ->실전은 위에껄로
@GetMapping("complete")
public String complete(Model model) {
	return "buy/complete";
}

}
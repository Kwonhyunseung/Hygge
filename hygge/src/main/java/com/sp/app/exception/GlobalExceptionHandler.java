package com.sp.app.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import lombok.extern.slf4j.Slf4j;

/*@ControllerAdvice
 * : 예외를 catch 해서 처리하도록 하는 어노테이션(400 error 과 500 error 등)
 * : 일반적인 웹 어플리케이션에서 사용되는 예외 처리 및 공통 기능을 제공
 * : 주로 뷰 리졸버를 사용하는 @Controller 와 함께 사용
 */

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {
	@ExceptionHandler(MissingServletRequestParameterException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public ModelAndView handleMissingParam(MissingServletRequestParameterException ex) {
		ModelAndView mav = new ModelAndView("error/error2");
		String title = "잘못된 요청입니다.";
		String msg = "죄송합니다.<br> <strong>400 - 요청을 처리할 수 없습니다.</strong>";

		mav.addObject("title", title);
		mav.addObject("message", msg);

		log.info("BAD_REQUEST - ", ex);

		return mav;
	}

	@ExceptionHandler(MethodArgumentTypeMismatchException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	public ModelAndView handleArgumentTypeMistmatch(MethodArgumentTypeMismatchException ex) {
		// 파라미터 타입이 일치하지 않는 경우
		ModelAndView mav = new ModelAndView("error/error2");
		String title = "잘못된 요청입니다.";
		String msg = "죄송합니다.<br> <strong>400 - 요청을 처리할 수 없습니다.</strong>";

		mav.addObject("title", title);
		mav.addObject("message", msg);

		log.info("BAD_REQUEST - ", ex);
		
		return mav;
	}

	@ExceptionHandler(NoResourceFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND) // 404
	public ModelAndView handleResourceNotFound(NoResourceFoundException ex) {
		// 해당 페이지 주소가 매핑되어있지 않는 경우(페이지를 찾을 수 없음)
		ModelAndView mav = new ModelAndView("error/error2");
		String title = "페이지를 찾을 수 없습니다.";
		String msg = "죄송합니다.<br> <strong>404 - 요청하는 페이지는 존재하지 않는 페이지입니다.</strong>";

		mav.addObject("title", title);
		mav.addObject("message", msg);

		log.info("NOT_FOUND - ", ex);

		return mav;
	}

	@ExceptionHandler(Exception.class)
	public ModelAndView handleServerError(Exception ex) {
		ModelAndView mav = new ModelAndView("error/error2");
		String title = "시스템 오류가 발생했습니다.";
		String msg = "죄송합니다.<br> <strong>요청을 처리할 수 없습니다.</strong>";

		mav.addObject("title", title);
		mav.addObject("message", msg);

		log.info("INTERNAL_SERVER_ERROR 등 - ", ex);

		return mav;
	}
}

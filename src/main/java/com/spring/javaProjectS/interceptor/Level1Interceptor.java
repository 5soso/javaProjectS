package com.spring.javaProjectS.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level1Interceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
		
		// 우수회원 이상 (정회원:2, 준회원:3, 비회원:99 포함)
		if(level > 1) {
			RequestDispatcher dispatcher;
			if(level == 99) { //비회원인 경우
				dispatcher = request.getRequestDispatcher("/message/memberNo");
			}
			else { //정회원 또는 준회원인 경우
				dispatcher = request.getRequestDispatcher("/message/memberLevelNo");
			}
			dispatcher.forward(request, response);
			return false;
		}
		return true;
	}

	
}

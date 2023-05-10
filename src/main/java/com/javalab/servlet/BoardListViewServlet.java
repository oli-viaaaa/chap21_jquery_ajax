package com.javalab.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 사용자로부터 Ajax 요청을 받고 받은 자료를 그래도 사용자 웹브라우저에 반환
 */
@WebServlet("/boardListView")
public class BoardListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public BoardListViewServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, 
						HttpServletResponse response) 
						throws ServletException, IOException {
		
		// 디버깅 
		System.out.println("BoardListView doGet()");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/x-json; charset=utf-8");
		
		 int list = 0;      
	      if(request.getParameter("list") != null) {
	    	  // 내용물이 있을 경우에만 파라미터에서 가져올 것
	         list = Integer.parseInt(request.getParameter("list"));
	      }
		
		
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		
		// 디버깅] 클라이언트로부터 ajax 요청으로 전달받은 값
		System.out.println("Servlet doGet id / pwd : " + id +" / " +pwd);
		
		out.print("At Server : id는 " + id + "이고 pwd는 "+pwd);
	}
}

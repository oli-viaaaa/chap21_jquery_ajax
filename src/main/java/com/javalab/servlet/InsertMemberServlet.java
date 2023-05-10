package com.javalab.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class InsertMemberServlet
 */
@WebServlet("/insertMember")
public class InsertMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertMemberServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, 
						  HttpServletResponse response)
						  throws ServletException, IOException {
		
		// 웹브라우저에서 보낸 파라미터 추출
		// 웹브라우저 : data :{id :id, pwd:pwd}
		String id = request.getParameter("id"); 
		String pwd = request.getParameter("pwd");
		
		// 데이터베이스 저장 작업
		// ...
		
		response.setContentType("text/plain");
		response.setCharacterEncoding("utf-8");
		
		PrintWriter out = response.getWriter();
		out.write("Received id : "+id+", pwd : " +pwd);
	}

}

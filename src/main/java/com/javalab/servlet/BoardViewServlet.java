package com.javalab.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.javalab.dao.BoardDAO;
import com.javalab.vo.BoardVo;

/**
 * 게시물 상세 조회 서블릿 클래스
 */
@WebServlet("/boardView")
public class BoardViewServlet extends HttpServlet {
   
   private static final long serialVersionUID = 1L;
   
   /**
    * GET 접근 시 (상세 조회 접근 시)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) 
      throws ServletException, IOException {
      
      // [디버깅]
      System.out.println("BoardViewServlet doGet()");
      
      request.setCharacterEncoding("utf-8");
      response.setContentType("text/html; charset=utf-8");
      
      // 파라미터 추출
      int no = 0;      
      if(request.getParameter("no") != null) {
    	  // 내용물이 있을 경우에만 파라미터에서 가져올 것
         no = Integer.parseInt(request.getParameter("no"));
      }

      // 게시물 조회
      BoardDAO dao = new BoardDAO();
      BoardVo board = dao.getBoardById(no);
      
      // 자바 객체를 다시 JSON Type 문자열로 변환.
      // - Gson 라이브러리를 이용해서 자바 객체를 json type 문자열로 변환
      Gson gson = new Gson();      
      String jsonString = gson.toJson(board);
      
      // [디버깅]
      System.out.println("서블릿, 클라이언트로 보낼 JSON 문자열 : " + jsonString);
      
      // 5.3 사용자의 웹브라우저에 쓰기
      PrintWriter out = response.getWriter();
      out.print(jsonString);
   }

}
package com.javalab.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.javalab.vo.Member;

@WebServlet("/memberSerialize")
public class MemberSerialize extends HttpServlet {

   private static final long serialVersionUID = 1L;

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {

      request.setCharacterEncoding("utf-8");
      response.setContentType("application/text; charset=UTF-8");
      
      // 클라이언트에서 serialize()함수로 묶어서 보낸 경우 추출
      // data: params
      String id = request.getParameter("id");
      String pwd= request.getParameter("pwd");
      String name= request.getParameter("name");
      String email= request.getParameter("email");

      // 서버의 시간을 String으로 변환(서버 날짜)
      LocalDate currentDate = LocalDate.now();
        String dateString = 
              currentDate.format(DateTimeFormatter.ofPattern("yyy-MM-dd"));   
      
      
      Member member = new Member(id, pwd, name, email, dateString);
      System.out.println("member.toString(): " + member.toString());
      
      //..........database 처리..............//
      
      // Gson으로 자바 객체를 다시 JSON Type 문자열로 변환
      Gson gson = new Gson();
      String jsonString = gson.toJson(member);
      
      PrintWriter out = response.getWriter();
      out.print(jsonString);         
      
   }
}
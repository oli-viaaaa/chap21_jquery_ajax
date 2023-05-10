package com.javalab.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDao {
	
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource dataSource;
	
	
	// 기본 생성자에서 환경변수를 통한 데이터베이스 관련 DataSource얻어옴
	// Server / contex.xml에 Resource로 세팅해놓은 정보
	public MemberDao() {
		System.out.println("여기는 MemberDao 생성자");
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// 아이디 중복 체크
	public boolean isIdExist(String id) {
		boolean result = false;
		try {
			con = dataSource.getConnection();
			// 오라클 decode문 사용 : count(*) 했을 때 1이면 true, 없다면 false
			String query = " select decode(count(*), 1, 'true', 'false') as result from tbl_member";
				   query += " where id=?";
				   System.out.println("prepareStatememt : " +query);
				   pstmt = con.prepareStatement(query);
				   pstmt.setString(1, id);
				   
				   rs = pstmt.executeQuery();
				   rs.next();
				   // 반환타입이 boolean형이므로, 문자열 타입 쿼리 결과를 boolean으로 변환
				   result = Boolean.parseBoolean(rs.getString("result"));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return result;
	}
	
	
	
	
	// DB 자원해제
	private void close()
	{
		try {
			if ( pstmt != null ){ 
				pstmt.close(); 
			}
			if ( con != null ){ 
				con.close(); 
			}
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
	} // end close()	
		
}

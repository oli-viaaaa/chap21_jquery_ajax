<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"  /> 
<!DOCTYPE html>
<html>
<head>
  <title>ajax 게시물 조회</title>
      <style type="text/css">
      body{
         display: flex;
         justify-content: center;
         align-items: center;
         height: 100vh;
      }
      table{
      	margin: auto;
      	border:1px solid #333;
      	border-collapse: collapse;
      	text-align: center;
      }
      td{
      	text-align: left;
      }
   </style>
    
   <!-- jQuery -->
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>     
   <script type="text/javascript">
    
       $(document).ready(function(){
         $('body').addClass('backColor');
         $('#btnSubmit').on('click',function(){
        	 var no = $('#pageNum').val();
        	 if(no==''){
        		 alert("페이지 번호를 입력하세요.");
        		 $('pageNum').focus();
        		 return;
        	 }
        	 // ajax요청(ajax 함수를 통해서 서버에 전송)
        	 $.ajax({
        		 url:"${contextPath}/boardList",
        		 type:"get",
        		 data : { pageNum: no},   // 서버로 보낼 데이터
        		 dataType : "text",   // 서버로부터 받을 데이터 타입
        		// 처리결과 성공시 호출되는 콜백 함수
                 success:function (result){
                	 // 1) 서버에서 받은 JSON Type 문자열을 자바 객체로 변환
                	 const boardList = JSON.parse(result);
                	 
                	 $('#output').empty(); // clear div
                	 
                	 // Build HTML table
                     var table = "<table border='1'>";
                     table += '<tr><th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th></tr>';
                     
                     $.each(boardList, function(index, board){
                    	 table += "<tr>";
                    	 table += "<td>" + (index + 1) + "</td>";
                    	 table += "<td>" + board.title + "</td>";
                    	 table += "<td>" + board.id + "</td>";
                    	 table += "<td>" + board.hit + "</td>";
                    	 table += "<td>" + board.regdate + "</td>";
                    	 table += "</tr>";
                     });
                     table += "</table>";
                     // 서버에서 받아온 데이터 출력
                     $('#output').append(table);
                     $('#output table').appClass('centered');
                 },// 처리결과 실패시 호출되는 콜백 함수
                 error:function(data,textStatus){
                     alert("에러가 발생했습니다.");ㅣ
                 },//success 콜백 호출후에 호출되는 콜백함수
                 complete:function(data,textStatus){
                 }
            });  //end ajax   
   
         });   // end onclick
            
      });   // end $(function() {
    </script>
</head>
<body>
	<div id="container">
		<form action="" method="get" class="centered">
			<h3>페이지 조회</h3>
			<h5>조회를 원하는 페이지 번호를 입력하세요.</h5>
			페이지 번호 : <input type="text" name="pageNum" id="pageNum" /><br><br>
			<input type="button" id="btnSubmit" value="조회"  /><br><br>
		</form>
		<div id="output">
		</div>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
	#id{
		background-color: pink;
</style>
<meta content="text/html; charset=UTF-8">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
 $(document).ready(function() {
	 // 이벤트 핸들러 -json type 변환
	$('#changeBtn').click(function(e){
		// submit() 되지 않도록
		e.preventDefault();
		
		// 입력값 추출
		let id = $('#id').val(); // id에 입력된 값
		let pwd = $('#pwd').val(); // pwd에 입력된 값
		
		// ajax 형태로 서블릿 호출(서버에 값 전달)
		$.ajax({
			url:'${contextPath}/insertMember', // 서버 url
			type:'post', // 요청방식(get, post, put 등)
			async:true, // 비동기 여부(default : true)
			// 서버로 전송할 데이터(key:value)
			data:{id: id, pwd: pwd},
			// 전달받을 데이터 타입(html, xml, json, text)
			dataType:'text',
			success:function(result){// 결과 성공 콜백 함수
				console.log(result); // 디버깅 받은 결고 ㅏ출력
				// 받은 결과를 특정 엘리먼트에 출력
				$('#result').text(result);
			},
			// 결과 에러 콜백함수
			error:function(request, status, error){
				console.log(error)
			}
		})
	});	
 }); // end ready()
</script>
</head>
<body>
	<h3>일반 문자열 상태로 서버에 요청, 서버에서 일반문자열 상태로 응답</h3>
	<h4>1. [전송]버튼을 클릭하면 자바스크립트 부분 jQuery의<br>
		2. ajax 함수를 통해서 서블릿으로 요청이 가고<br>
		3. 서블릿은 요청을 처리하고 그 결과를 일반 문자열로<br>
		   웹 브라우저로 전송<br>
		4. 클라이언트의 자바스크립트 부분에서 서버에서 받은 결과를<br>
		   화면에 보여줌.</h4>
	<br><br>
	<form action="www.naver.com" method="get">
		아이디 : <input type="text" id="id"><br>
		비밀번호 : <input type="password" id="pwd">
		<br><br>
		<button id="changeBtn">전송</button>
	</form>
	<div id="result"></div>
</body>
</html>
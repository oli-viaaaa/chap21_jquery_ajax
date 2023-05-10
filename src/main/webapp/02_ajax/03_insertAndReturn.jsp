<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<c:set var="contextPath" value="${pageContext.request.contextPath}" />      
<!DOCTYPE html>
<html>
<head>
   <meta content="text/html; charset=UTF-8">
   <!-- jQuery -->
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script>         
      $(document).ready(function(){
         // 이벤트 핸들러 - json type 변환
         $("#changeBtn").on('click', function(e){ 
            // submit()되지 않도록 
            e.preventDefault();
         
            // 1. 입력값 추출
            let id = $('#id').val();   // id에 입력된 값
            let pwd = $('#pwd').val();   // pwd에 입력된 값

            // 2. 입력값으로 자바스크립트 객체 생성
            // 데이터 양이 많을 경우에 한번에 넣어서 전송
            let obj = new Object();
            obj.id = id;
            obj.pwd = pwd;
            
            // 3. JSON.stringify(obj) 스트링지파이 함수
            //  - 자바스크립트 객체를 JSON Type 문자열로 변환
            var jsonData = JSON.stringify(obj);
            console.log('보내기전 jsonData : ', jsonData);               
            
            // ajax 형태로 서블릿 호출(서버에 값 전달)
            $.ajax({
               url : '${contextPath}/insertAndReturn',  // 서버 url
               type : 'post',              // 요청방식 (get, post, put 등등)
               async : true,               // 비동기 여부 (default : true)
               data : {data2: jsonData},   // 서버로 전송할 데이터(key:value)
               dataType : 'text',          // 전달받을 데이터타입(html,xml,json,text)
               success : function(result) { // 결과 성공 콜백함수
               console.log('서버 처리결과 받은 jsonData : ', result);   // [디버깅]받은 결과 출력
                    
                // 1) 서버에서 받은 JSON Type 문자열을 자바스크립트 객체로 변환
                   const member = JSON.parse(result);
                   console.log('JSON.parse(member) : ', member);   // [디버깅]받은 결과 출력
                    
                 // 2. result가 div태그라서 text()함수로 값세팅
                    $('#result').text(result);// 받은 결과를 특정 엘리먼트에 출력
                    
                 // 3. 반환 아이디에 서버에서 받은 값세팅
                 // returnId가 input 태그라서 val() 함수 사용
                    $('#returnId').val(member.id);
                    $('#returnPwd').val(member.pwd);                       
                },
                error : function(request, status, error) { // 결과 에러 콜백함수
                    console.log(error)
                }
            })
         });    
      });
   </script>   
</head>
<body>
   <h3> 화면 입력값을 JSON 문자열로 변환하여 서버에 전달,<br>
       서버에서는 자바 객체를 JSON 문자열로 응답</h3>
   <h4>1. [전송]버튼을 클릭하면 자바스크립트 부분에서 입력값을 <br>
       JSON 타입 문자열로 변환하고<br>
      2.  jQuery의 ajax 함수를 통해서 서블릿으로 전송<br>
      3. 서블릿은 전송된 데이터가 json type의 문자열이므로<br>
         문자열을 자바 객체로 변환하여 처리하는게 편리.<br>
      4. 서블릿에서 웹브라우저로 전송하기 전에 자바 쪽에서 만든 객체를 다시 <br>
      JSON Type 문자열로 변환하여 사용자에게 반환한다.<br>
      5. 사용자의 자바스크립트에서는 서버에서 받은 JSON Type 문자열을<br>
      자바스크립트 객체로 파싱(변환) 하여 사용
      </h4>
      
   <br><br>
   <form action="www.naver.com" method="get">
      아이디 : <input type="text" id="id"><br>
      비밀번호 : <input type="password" id="pwd">
      <br><br>
      <button id="changeBtn">JSON Type 전송</button>
   </form>
   <div id="result"></div>
   <br>
   <div>
      반환 아이디 : <input type="text" id="returnId"><br>
      반환 비밀번호 : <input type="password" id="returnPwd">
   </div>   

</body>
</html>
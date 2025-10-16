<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <style>
        table, tr, td, th{
            border : 1px solid black;
            border-collapse: collapse;
            padding : 5px 10px;
            text-align: center;
        }
        th{
            background-color: beige;
        }
        tr:nth-child(even){
            background-color: azure;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <table>
            <tr>
                <th>제목</th>
                <td><input type="text" v-model="title"></td>
            </tr>
            <tr>
                <th>아이디</th>    
                <td>{{userId}}</td>
            </tr>
            <tr>
                <th>파일</th>
                <td><input type="file" id="file1" name="file1" accept=".jpg , .png"></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><input type="text" v-model="contents"></td>
            </tr>
         </table>
         <div>
            <button @click="fnAdd">글쓰기</button>
         </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                userId :"${sessionId}",
                title:"",
                contents:""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAdd: function () {
                let self = this;
                let param = {
                    id:self.userId,
                    title:self.title,
                    contents:self.contents
                };
                $.ajax({
                    url: "/bbs-add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("작성되었습니다.")
                        console.log(data);
                        
	                    var form = new FormData();
	                    form.append( "file1",  $("#file1")[0].files[0] );
	                    form.append( "bbsNo",  data.bbsNo); // 임시 pk
	                    self.upload(form);  
                    }
                });
            },
             upload (form){
	            let self = this;
	             $.ajax({
	            	 url : "/bbs/fileUpload.dox"
	               , type : "POST"
	               , processData : false
	               , contentType : false
	               , data : form
	               , success:function(response) { 
                    location.href='/bbs/list.do';
	               }	           
            });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>
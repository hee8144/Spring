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
         {{sessionName}}님 환영합니다
        <div>
            <a href="/board-list.do">
                <button>게시판으로 이동</button>
            </a>

            <a href="/product.do">
                <button>제품리스트로 이동</button>
            </a>

            <a href="/bbs/list.do">
                <button>BBS게시판으로 이동</button>
            </a>
            <button @click="fnLogout">로그아웃</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                sessionId : "${sessionId}",
                sessionName : "${sessionName}",
                sessionStatus : "${sessionStatus}",
                code:""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnLogout: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/member/logout.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.msg);
                        location.href="/member/login.do";
                        
                    }
                });
            },
            fnkakao() {
            	var self = this;
            	var nparmap = {
            		code : self.code
            	};
            	$.ajax({
            		url: "/kakao.dox",  
            		dataType: "json",
            		type: "POST",
            		data: nparmap,
            		success: function (data) {
            			console.log(data);
                        self.sessionName = data.properties.nickname;
                        
            		}
            	});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            const queryParams = new URLSearchParams(window.location.search);
            self.code = queryParams.get('code') || ''; 

            if(self.code != null){
                self.fnkakao();
            }
        }
    });

    app.mount('#app');
</script>
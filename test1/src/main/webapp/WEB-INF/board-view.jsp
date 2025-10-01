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
        #board table, tr, td, th{
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

        <table id="board">
            <tr>
                <th>번호</th>
                <td>{{boardNo}}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td>{{info.title}}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>{{info.userId}}</td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>{{info.cnt}}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td>{{info.contents}}</td>
            </tr>
            <tr>
                <th>작성일</th>
                <td>{{info.cdate}}</td>
            </tr>
        </table>

        <hr>

        <table id="comment">
            <tr v-for="item in comment">
                <th>{{item.nickName}}</th>
                <td>{{item.contents}}</td>
                <td><button @click="fnRemove(item.commentNo)">삭제</button></td>
                <td><button>수정</button></td>
            </tr>
        </table>

        <hr>

        <table id="input">
            <th>댓글입력</th>
            <td>
                <textarea cols="50" rows="5" v-model="contents"></textarea>
            </td>
            <td><button @click="fnAddComment">저장</button></td>
        </table>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                boardNo:"${boardNo}",
                info:{},
                comment:{},
                userId:"${sessionId}",
                contents:""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {boardNo : self.boardNo};
                $.ajax({
                    url: "/board-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        
                        self.info=data.info;
                        self.comment = data.commentList;
                        console.log(data.commentList);
                        
                    }
                });
            },
            fnRemove(commentNo){
                let self = this;
                let param = {commentNo : commentNo};
                if(!confirm("삭제하시겠습니까?")){
                    return;
                }
                $.ajax({
                    url: "/commnet-remove.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("삭제되었습니다.")
                        self.fnInfo();
                    }
                });
            },
            fnAddComment(){

                let self = this;
                let param = {
                     boardNo: self.boardNo,
                     contents:self.contents,
                     userId:self.userId 
                    };
                $.ajax({
                    url: "/commnet-add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        self.fnInfo();
                        self.contents=""
                        alert(data.msg)

                    }
                });
            }

        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            console.log(self.boardNo);
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>
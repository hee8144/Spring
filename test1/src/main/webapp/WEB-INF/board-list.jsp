<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
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
        <div>
            <div>
                <select name="" v-model="kind" @change="fnList">
                    <option value="">:: 전체 ::</option>
                    <option value="1">:: 공지사항 ::</option>
                    <option value="2">:: 자유계시판 ::</option>
                    <option value="3">:: 문의계시판 ::</option>
                </select>

                <select  v-model="sort" @change="fnList">
                    <option value="BOARDNO">:: 번호순 ::</option>
                    <option value="TITLE">:: 제목순 ::</option>
                    <option value="CNT">:: 조회순 ::</option>
                </select>
            </div>
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.boardNo}}</td>
                    <td><a href="javascript:;" @click="fnview(item.boardNo)">{{item.title}}</a></td>
                    <td>{{item.userId}}</td>
                    <td>{{item.kind}}</td>
                    <td>{{item.cdate}}</td>
                    <td><button @click="fnRemove(item.boardNo)">삭제</button></td>
                </tr>
            </table>
        </div>
        <div>
            <a href="board-add.do"><button>글쓰기</button></a>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
				keyword:"",
                list:[],
                kind:"",
                sort:"BOARDNO"
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
             fnList: function () {
                let self = this;
                let param = {
                    kind : self.kind,
                    sort : self.sort
                };
                console.log(self.sort);
                
                $.ajax({
                    url: "board-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data)
                        self.list = data.list;
                        
                    }
                });
            },
             fnRemove(boardNo){
                 let self = this;
                 let param = {boardNo : boardNo};
                 $.ajax({
                     url: "board-remove.dox",
                     dataType: "json",
                     type: "POST",
                     data: param,
                     success: function (data) {
                        alert("삭제되었습니다.");
                        self.fnList();
                     }
                 });
             },
            fnview(boardNo){
                pageChange("board-view.do",{boardNo : boardNo});
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnList();
        }
    });

    app.mount('#app');
</script>
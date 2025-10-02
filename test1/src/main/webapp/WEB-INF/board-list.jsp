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
        #index{
            margin-right: 5px;
            text-decoration: none;

        }
        .active{
            color: black;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div>
            <div>
                <select v-model="keywordSort">
                    <option value="all">:: 전체 ::</option>
                    <option value="title">:: 제목 ::</option>
                    <option value="userId">:: 작성자 ::</option>
                </select>
                <input type="text" v-model="keyword">
                <button @click="fnList">검색</button>
            </div>

            <div>
                <select v-model="pageSize" @change="fnList">
                    <option value="5">5개씩</option>
                    <option value="10">10개씩</option>
                    <option value="20">20개씩</option>
                </select>
            </div>

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
                    <option value="CDATE">:: 시간순 ::</option>
                </select>
            </div>
            <table>
                <tr>
                    <th><input type="checkbox" v-model="all" @click="fnSelectAll"></th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>삭제</th>
                </tr>
                <tr v-for="item in list">
                    <td><input type="checkbox" :value="item.boardNo" v-model="selectItem"></td>
                    <td>{{item.boardNo}}</td>
                    <td>
                        <a href="javascript:;" @click="fnview(item.boardNo)">{{item.title}} </a>
                        <span v-if="item.commentCnt != 0" style="color: red;">[{{item.commentCnt}}]</span>
                    </td>
                    <td>{{item.userId}}</td>
                    <td>{{item.cnt}}</td>
                    <td>
                        <span>{{item.cdate}}</span>
                        <span v-if="Date().date == item.cdate">{{item.chour}}</span>
                    </td>
                    <td>
                        <button v-if="item.userId == sessionId || sessionStatus == 'A'" @click="fnRemove(item.boardNo)">삭제</button>
                    </td>
                </tr>
            </table>

            <div>
                <button @click="fnAllRemove">삭제</button>
            </div>
        </div>
        <div>
            <a href="javascript:;" @click="fnMove(-1)">
                <span v-if="page > 1">
                    ◀
                </span>
            </a>
            <a id="index" href="javascript:;" v-for="num in index" @click="fnchange(num)">
                <span :class="{active : page == num}">{{num}}</span>
            </a>
            <a href="javascript:;" @click="fnMove(+1)">
                <span v-if="page != index ">▶</span>
            </a>
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
                list:[],
                selectItem:[],
				keyword:"",
                kind:"",
                sort:"CDATE",
                keywordSort:"all",
                all:false,

                pageSize:5, // 한페이지에 출력할 개수
                page:1,//현재페이지
                index:0,//몇페이지까지 존재하는지
                
                sessionId : "${sessionId}",
                sessionStatus : "${sessionStatus}",
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
             fnList: function () {
                let self = this;
                let param = {
                    kind : self.kind,
                    sort : self.sort,
                    keywordSort: self.keywordSort,
                    keyword:self.keyword,

                    pageSize:self.pageSize,
                    page : (self.page-1) * self.pageSize,
                };
                
                $.ajax({
                    url: "board-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data)
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt/ self.pageSize);
                        
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
            },
            fnchange(num){
                let self = this;
                self.page=num;
                console.log(self.page);
                
                self.fnList();
            },
            fnMove(num){
                let self=this;
                self.page +=  num;
                self.fnList();
            },
            fnSelectAll(){
                let self = this;
                console.log(self.selectItem);
                
                if(!self.all){
                    self.selectItem =[];
                    for(let i = 0; i<self.list.length ;i++){
                        self.selectItem.push(self.list[i].boardNo);
                    }
                }else{
                    for(let i = 0; i<self.list.length ;i++){
                        self.selectItem= [];
                    }
                }
            },
            fnAllRemove(){
                let self= this;
                var fList = JSON.stringify(self.selectItem);
                var param = {selectItem : fList};
                $.ajax({
                     url: "/board/deleteList.dox",
                     dataType: "json",
                     type: "POST",
                     data: param,
                     success: function (data) {
                        alert("삭제되었습니다.");
                        self.fnList();
                     }
                 });
                
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
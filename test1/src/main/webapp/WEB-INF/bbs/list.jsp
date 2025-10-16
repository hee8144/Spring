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
        a{
            color: inherit;
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
                <select v-model="pageSize" @change="fnList">
                    <option value="5">5개씩</option>
                    <option value="10">10개씩</option>
                    <option value="20">20개씩</option>
                </select>
            </div>
            
            <div>
                <select v-model="keywordSort">
                    <option value="all">:: 전체 ::</option>
                    <option value="title">:: 제목 ::</option>
                    <option value="userId">:: 작성자 ::</option>
                </select>
                <input type="text" v-model="keyword">
                <button @click="fnList">검색</button>
            </div>

            
            <table>
                <tr>
                    <th>선택</th>
                    <th>번호</th>
                    <th>제목</th>
                    <th>조회수</th>
                    <th>작성자</th>
                    <th>작성일</th>
                </tr>
                <tr v-for="item in list">
                    <td><input type="radio" :value="item.bbsNum" v-model="selectItem"></td>
                    <td>{{item.bbsNum}}</td>
                    <td>
                        <span v-if="item.hit > 25" style="color:red">
                           <a href="javascript:;" @click="fnView(item.bbsNum)">
                                {{item.title}}
                           </a> 
                        </span>
                        <span v-else>
                            <a href="javascript:;" @click="fnView(item.bbsNum)">
                                {{item.title}}
                            </a>
                        </span>
                    </td>
                    <td>{{item.hit}}</td>
                    <td>{{item.userId}}</td>
                    <td>{{item.Cdate}}</td>
                </tr>
            </table>

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
                <a href="/bbs/list-add.do" style="margin-right: 20px;">
                    <button >글쓰기</button>
                </a> 
                <button @click="fnRemove">삭제</button>
            </div>
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
                selectItem:"",
                pageSize:5,
                index:0,
                page:1,
                keywordSort:"all",
                keyword:""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    pageSize:self.pageSize,
                    page : (self.page-1) * self.pageSize,
                    keywordSort:self.keywordSort,
                    keyword:self.keyword
                };
                $.ajax({
                    url: "/bbs-list.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.index = Math.ceil(data.cnt/ self.pageSize);
                    }
                });
            },
            fnRemove(){
                let self = this;
                let param = {
                    bbsNo:self.selectItem
                };
                if(!confirm("정말 삭제하시겠습니까?")){
                    return;
                }
                $.ajax({
                    url: "/bbs-remove.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        alert("삭제되었습니다.");
                        self.fnList();
                    }
                });
            },
            fnView(bbsNum){
                pageChange("list-view.do",{bbsNum : bbsNum});
            },
            fnMove(num){
                let self=this;
                self.page +=num;
                self.fnList();
            },
            fnchange(num){
                let self=this;
                self.page = num;
                self.fnList();
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
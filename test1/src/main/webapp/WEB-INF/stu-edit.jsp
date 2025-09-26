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
                <th>번호</th>
                <td>{{stuNo}}</td>
            </tr>
            <tr>
                <th>학과</th>
                <td><input type="text" v-model="stuDept"></td>
            </tr>
            <tr>
                <th>시험평균점수</th>
                
                <td>
                    <span v-if="info.AVGGRADE != null">
                        {{info.AVGGRADE}}
                    </span>
                    <span v-else>
                        0
                    </span>
                </td>
            </tr>

            <tr>

            </tr>
        </table>
        <div>
            <button @click="fnedit">수정</button>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                stuNo:"${stuNo}",
                info:{},
                stuDept:""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {stuNo : self.stuNo};
                $.ajax({
                    url: "stu-view.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        
                        self.info=data.info;
                        self.stuDept =data.info.stuDept
                    }
                });
            },
            fnedit(){

                let self = this;
                let param = {stuNo : self.stuNo,
                    stuDept : self.stuDept
                };
                $.ajax({
                    url: "stu-edit.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("수정되었습니다.");
                        location.href="stu-list.do"                        
                    }
                });                
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            console.log(self.stuNo);    
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>
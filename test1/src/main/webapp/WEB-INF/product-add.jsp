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

        <div>


            <table>
                <tr>
                    <th>음식종류</th>
                    <td>
                        <select name="" id="">
                            <option :value="item.menuNo" v-for="item in list">                                
                                {{item.menuName}}
                            </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" v-model="name"></td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td><textarea name="" id="" v-model="info"></textarea></td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td><input type="text" v-model="price"></td>
                </tr>
                <tr>
                    <th>이미지</th>
                    <td><input type="file" id="file1" name="file1" accept=".jpg , .png"></td>
                </tr>
            </table>
            <button>저장</button>
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
                name:"",
                info:"",
                price:""
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {};
                $.ajax({
                    url: "/product/menulist.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        self.list = data.menuList;
                    }
                });
            },
            fnadd(){
                var self = this;
	            var form = new FormData();
	            form.append( "file1",  $("#file1")[0].files[0] );
	            form.append( "name",  self.name); // 임시 pk
	            self.upload(form);  
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
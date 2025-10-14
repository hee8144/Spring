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
                        <select v-model="menuPart">
                            <option :value="item.menuNo" v-for="item in list">                                
                                {{item.menuName}}
                            </option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>제품번호</th>
                    <td><input type="text" v-model="menuNo"></td>
                </tr>
                <tr>
                    <th>음식명</th>
                    <td><input type="text" v-model="foodName"></td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td><textarea cols="25" rows="5" v-model="foodInfo"></textarea></td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td><input type="text" v-model="price"></td>
                </tr>
                <tr>
                    <th>이미지</th>
                    <td><input type="file" id="file1" name="file1" accept=".jpg , .png" multiple></td>
                </tr>
            </table>
            <div>
                <button @click="fnAddProduct">제품등록</button>
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
                menuPart:"10",
                menuNo:"",
                foodName:"",
                foodInfo:"",
                foodKind:"",
                price:"",
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    depth : 1
                };
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
            fnAddProduct: function () {
                let self = this;
                if(self.menuPart==10 ){
                    self.foodKind="한식";
                }else if(self.menuPart==20){
                    self.foodKind="중식";
                }else if(self.menuPart==30){
                    self.foodKind="양식";
                }else if(self.menuPart==40){
                    self.foodKind="디저트";
                }else if(self.menuPart==50){
                    self.foodKind="음료";
                }
                let param = {
                    menuPart:self.menuPart,
                    menuNo:self.menuNo,
                    foodName:self.foodName,
                    foodInfo:self.foodInfo,
                    price:self.price,
                    foodKind:self.foodKind,
                };
                 
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        if(data.result == 'success'){
                            alert("등록되었습니다.");
                        }else{
                            alert("오류가발생했습니다.");
                        }
                        console.log($("#file1")[0].files);
                        
                        var form = new FormData();
                        for(let i = 0; i<$("#file1")[0].files.length;i++){
                            form.append( "file1",  $("#file1")[0].files[i] );
                            form.append( "foodNo",  data.foodNo); // 임시 pk
                            self.upload(form)
                        }
                    }
                });
            },
            upload : function(form){
	            var self = this;
            	 $.ajax({
		            url : "/product/fileUpload.dox"
	                , type : "POST"
	                , processData : false
	                , contentType : false
	                , data : form
	                , success:function(response) { 
                        
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
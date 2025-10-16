<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
        img{
            width: 100%;
            height: 220px;
            border-radius: 5px;
            
        }
        span{
            display: inline-block;
            width: 100px;
            margin-right: 20px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <div>
            <table>
                <tr>
                    <th>이미지</th>
                    <td >
                        <span v-for="item in img">
                            <img :src="item.filepath" alt="">
                        </span>
                    </td>
                </tr>
                <tr>
                    <th>제품이름</th>
                    <td>{{info.foodName}}</td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td>{{info.price}}</td>
                </tr>
                <tr>
                    <th>종류</th>
                    <td>{{info.foodKind}}</td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td>
                        <p v-html="info.foodInfo"></p>
                        {{info.foodInfo}}
                    </td>
                </tr>
                <tr>
                    <th>개수</th>
                    <td><input type="text" v-model="num"></td>
                </tr>
            </table>
            <div>
                <button @click="fnPayment()">주문하기</button>
            </div>
         </div>
    </div>
</body>
</html>

<script>
    const userCode = "imp47205231"; 
	IMP.init(userCode);

    const app = Vue.createApp({
        
        data() {
            return {
                // 변수 - (key : value)
                foodNo:"${foodNo}",
                sessionId:"${sessionId}",
                info:{},
                img:[],
                num:"",
                list:[]
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnInfo: function () {
                let self = this;
                let param = {
                    foodNo:self.foodNo
                };
                $.ajax({
                    url: "/product/Info.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        console.log(data.img);
                        
                        self.info = data.Info;
                        self.img = data.img;
                    }
                });
            },
            fnPayment(){
                let self=this;
                IMP.request_pay({
				    pg: "html5_inicis",
				    pay_method: "card",
				    merchant_uid: "merchant_" + new Date().getTime(),
				    name: self.info.foodName,
				    amount: 1, //self.price * self.num
				    buyer_tel: "010-0000-0000",
				  }	, function (rsp) { // callback
			   	      if (rsp.success) {
			   	        // 결제 성공 시
						console.log(rsp);
                        self.list = rsp;
                        console.log(self.list);
                        self.fnPayHistory();
			   	      } else {
			   	        // 결제 실패 시
						alert("실패");
			   	      }
		   	  	});
            },
            fnPayHistory(){
                let self=this;
                let param = {
                            impId: self.list.imp_uid,
                            id:self.sessionId,
                            amount:self.list.paid_amount,
                            productNo:self.foodNo,
                        };
                        $.ajax({
                            url: "/product/history.dox",
                            dataType: "json",
                            type: "POST",
                            data: param,
                            success: function (data) {
                                console.log(data);
                                if(data.result == success){
                                    alert("결제되었습니다.");
                                }else{
                                    alert("오류가 발생했습니다.");
                                }
                                
                            }
                        });

            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            self.fnInfo();
        }
    });

    app.mount('#app');
</script>
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
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
        <div v-if="!authFlg">
            <div>
                <label for="">아이디 : <input type="text" v-model="userId"></label>
            </div>
            <div>
                <label for="">이름 : <input type="text" v-model="name"></label>
            </div>
            <div>
                <label for="">번호 : <input type="text" placeholder="-를 제외하고 입력해주세요." v-model="phone" ></label>
            </div>
            <div>
                <button @click="fnAuth">인증</button>
            </div>
        </div>
            <div v-else>
            <div>
                <label for="">비밀번호 : <input type="text" v-model="pwd1"></label>
            </div>
            <div>
                <label for="">비밀번호확인 : <input type="text" v-model="pwd2"></label>
            </div>
            <div>
                <button @click="fnPwd">비밀번호 수정</button>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    IMP.init("imp47205231");
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                authFlg:false,
                userId:"",
                name:"",    
                phone:"",
                pwd1:"",
                pwd2:"",
                pwdRegex:/^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/,
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnAuth: function () {
                let self = this;

                let param = {
                    id:self.userId.trim(),
                    name:self.name.trim(),
                    phone:self.phone.trim()
                    
                };
                $.ajax({
                    url: "/member/pwd.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.result=="success"){
                            alert("인증되었습니다.")
                            self.fnCerti(); 
                            
                        }else{
                            alert("사용자 정보를 찾을 수 없습니다.")
                        }
                        
                    }
                });
            },
            fnPwd(){
                let self = this;

                if(!self.pwdRegex.test(self.pwd1)){
                    alert("비밀번호는 6자리 이상 특수문자 1개 포합입니다.");
                    return;
                }
                
                if(self.pwd1 != self.pwd2){
                    alert("비밀번호가 일치하지않습니다.");
                    return;
                }

                    let param = {
                    id:self.userId.trim(),
                    pwd:self.pwd1.trim(),
                }
                $.ajax({
                    url: "/member/updatePwd.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        alert(data.msg)
                    }
                });
            },
            fnCerti(){
                // IMP.certification(param, callback) 호출
                let self =this
                IMP.certification(
                  {
                    // param
                    channelKey: "channel-key-009bb29e-cec6-4dab-9462-fd4601658a54",
                    merchant_uid: "merchant_" + new Date().getTime(), // 주문 번호
                  },
                  function (rsp) {
                    // callback
                    if (rsp.success) {
                        // 인증 성공 시 로직
                        alert("결제 성공");
                        console.log(rsp);
                        self.authFlg = true;
                    } else {
                      // 인증 실패 시 로직
                      alert("결제 실패");
                      console.log(rsp);
                    }
                  },
                );
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;   
        }
    });

    app.mount('#app');
</script>
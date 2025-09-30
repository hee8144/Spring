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
        .phone{
            width: 40px;
        }
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->

        <div>

            <div>
                 <input v-if="!idFlg" v-model="id">
                <input v-else v-model="id" disabled>
                <button @click="fnCheck">중복체크</button>
            </div>

            <div>
                <label for=""> 비밀번호 : <input type="password" v-model="pwd"></label>
            </div>

            <div>
                <label for=""> 비밀번호확인 : <input type="password" v-model="pwd2"></label>
            </div>

            <div>
                 이름 : <input type="text" v-model="name">
            </div>

           <div>
                주소: <input v-model="addr" disabled> <button @click="fnAddr">주소검색</button>
           </div>

           <div>
                핸드폰 번호 : 
                <input type="text" maxlength="3" class="phone" v-model="phone1">-
                <input type="text" maxlength="4" class="phone" v-model="phone2">-
                <input type="text" maxlength="4" class="phone" v-model="phone3">
           </div>

           <div v-if="!joinFlg">
                문자인증 <input type="text" v-model="inputNum" :placeholder="timer">
                
                <template v-if="!smsFlg">
                    <button @click="fnSms ">인증번호 전송</button>
                </template>
                <template v-else>
                    <button @click="fnSmsAuth">인증</button>
                </template>
           </div>
           <div v-else style="color:red">
                문자인증이 완료되었습니다.
           </div>

           <div>
                성별 : 
                <label for=""><input type="radio" v-model="gender" value="M">남자</label> 
                <label for=""><input type="radio" v-model="gender" value="F">여자</label> 
           </div>
           
           <div>
                <select name="" id="" v-model="status">
                    <option value="A">관리자</option>
                    <option value="S">판매자</option>
                    <option value="C">소비자</option>
                </select>
           </div>
           <div>
                <button @click="fnJoin">회원가입</button>
           </div>
        </div>

    </div>
</body>
</html>

<script>
    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
            
            window.vueObj.fnResult(roadFullAddr, addrDetail,zipNo);
            
        }
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                id:"",
                pwd:"",
                pwd2:"",
                pwdRegex:/^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/,
                idRegex:/^(?=.*[a-z0-9])[a-z0-9]{5,16}$/,
                addr:"",
                name:"",
                phone1:"",
                phone2:"",
                phone3:"",
                gender:"M",
                status:"A",

                inputNum:"",
                smsFlg:false,
                timer:"",
                count:180,
                joinFlg : false,
                ranStr:"",
                idFlg:false,

            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnJoin: function () {
                let self = this;
                let param = {
                    id:self.id,
                    pwd:self.pwd,
                    name:self.name,
                    addr:self.addr,
                    phone:self.phone1+"-"+self.phone2+"-"+self.phone3,
                    gender:self.gender,
                    status:self.status,
                };
                if(!idFlg){
                    alert("중복체크를 해주세요");
                    return;
                }
                
                if(self.pwd != self.pwd2 ){
                    alert("비밀번호가 다릅니다.");
                    return;
                }

                if(!self.pwdRegex.test(self.pwd)){
                    alert("비밀번호는 6자리 이상 특수문자 1개 포합입니다.");
                    return;
                }

                if(self.name ==""){
                    alert("이름을 입력해주세요");
                    return;
                }

                if(self.addr == ""){
                    alert("주소를 입력해주세요");
                    return;
                }

                if(self.phone1.length < 3 || self.phone2.length < 4 || self.phone3.length<3){
                    alert('핸드폰번호를 입력해주세요');
                    return;
                }

                if(!self.joinFlg){
                    alert("문자 인증을 실행해주세요");
                    return;
                }

                $.ajax({
                    url: "/member/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert("회원가입되었습니다.");
                        location.href="/member/login.do";
                    }
                });
            },
            fnCheck(){
               let self = this;
                let param = {
                    id : self.id
                };

                if(!self.idRegex.test(self.id)){
                    return;
                }
                
                $.ajax({
                    url: "/member/check.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        alert(data.msg);
                        self.idFlg=true;
                    }
                }); 
            },
            fnAddr(){
                window.open("/addr.do","addr","width=500 , height=500");
            },
            fnResult(roadFullAddr, addrDetail,zipNo){
                let self = this;
                self.addr = roadFullAddr;
            },
            fnSms(){
                let self=this;
                let param = {};
                $.ajax({
                    url: "/send-one",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        console.log(data);
                        if(data.res.statusCode=="2000"){
                            alert("문자전송완료");
                            self.ranStr = data.ranStr;
                            self.smsFlg=true;
                            self.fnTimer();
                        }else{
                            alert("잠시 후 다시 시도해주세요");
                        }
                    }
                });
                
            },
            fnTimer(){
                let self=this;

                let interval = setInterval(() => {
                    if(self.count==0){
                        clearInterval(interval);
                        alert("시간이만료되었습니다.")
                    }else{
                        let min = parseInt(self.count / 60); 
                        let sec = self.count % 60;
                        
                        min = min < 10 ? "0" + min : min;
                        sec = sec < 10 ? "0" + sec : sec;
                        self.timer = min+ " : "  + sec;
                        
                        self.count--;
                    }
                }, 1000);
            },
            fnSmsAuth(){
                let self = this;
                if(self.ranStr == self.inputNum){
                    alert("문자인증이 완료되었습니다.");
                    self.joinFlg = true;
                } else {
                    alert("문자인증에 실패했습니다.");
                }
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            window.vueObj=this;
        }
    });

    app.mount('#app');
</script>
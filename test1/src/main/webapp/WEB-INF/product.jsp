<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>쇼핑몰 헤더</title>
    <link rel="stylesheet" href="/css/product-style.css">
    <script src="/js/page-change.js"></script>
    <script src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    
</head>

<body>
    <div id="app">
        <header>
            <div class="logo">
                <img src="/img/logo.png" alt="쇼핑몰 로고">
            </div>
            <nav>
                <ul>
                    <li v-for="item in menuList"  class="dropdown">
                        <a href="javascript:;" v-if="item.depth == 1"  @click="fnFoodList(item.menuNo, '')">
                            {{item.menuName}}
                        </a>
                        <ul class="dropdown-menu" v-if="item.cnt !=0">
                            <li v-for=" list in menuList">
                                <a href="#" v-if="list.depth==2 && list.menuPart == item.menuNo" @click="fnFoodList('',list.menuNo)">
                                    {{list.menuName}}
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div id="google_translate_element"></div>
            <div class="search-bar">
                <input type="text" placeholder="상품을 검색하세요..." v-model="keyWord" @keyup.enter="fnFoodList()">
                <button @click="fnFoodList()" >검색</button>
            </div>
            <div class="login-btn">
                <button>로그인</button>
            </div>
        </header>

        <main>
            <section class="product-list">
                <!-- 제품 항목 -->
                <div class="product-item" v-for="item in list" @click="fnview(item.foodNo)">
                    <img :src="item.filepath" :alt="item.fileName">
                    <h3>
                        {{item.foodName}}
                    </h3>
                    <p>
                        {{item.foodInfo}}
                    </p>
                    <p class="price">
                        ₩{{item.price.toLocaleString()}}
                    </p>
                </div>

            </section>
        </main>
    </div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list:[],
                menuList:[],
                subMenuList:[],
                keyWord:"",
            };
        },
        methods: {
            fnLogin() {
                var self = this;
                var nparmap = {};
                $.ajax({
                    url: "login.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                    }
                });
            },
            fnFoodList(part,menuNo) {
                var self = this;
                var nparmap = {
                    keyWord : self.keyWord,
                    part : part,
                    menuNo:menuNo
                };
                
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function (data) {
                        console.log(data);
                        self.list = data.list;
                        self.menuList = data.menuList;
                        self.subMenuList = data.subMenuList;
                        
                    }
                });
            },
            fnview(foodNo){
                pageChange("/product/view.do",{foodNo:foodNo})
            }
        },
        mounted() {
            var self = this;
            self.fnFoodList();
            new google.translate.TranslateElement({pageLanguage: 'ko',includedLanguages : 'ko,en,ja',autoDisplay: false}, 'google_translate_element');
        }
    });
    app.mount('#app');
</script>
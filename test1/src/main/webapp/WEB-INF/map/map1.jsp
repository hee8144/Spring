<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=82a2d2e3883834b8a2b2cf1015b17f3e&libraries=services"></script>
    <style>
       
    </style>
</head>
<body>
    <div id="app">
        <!-- html 코드는 id가 app인 태그 안에서 작업 -->
         <select style="margin-bottom : 20px; padding:5px" v-model="mark"  @change="fnSearch()">
        	<option value="">:: 선택 ::</option>
        	<option value="MT1">대형마트</option>
        	<option value="CS2">편의점</option>
        	<option value="PS3">어린이집, 유치원</option>
        	<option value="SC4">학교</option>
        	<option value="AC5">학원</option>
        	<option value="PK6">주차장</option>
        	<option value="OL7">주유소, 충전소</option>
        	<option value="SW8">지하철역</option>
        	<option value="BK9">은행</option>
        	<option value="CT1">문화시설</option>
        	<option value="AG2">중개업소</option>
        	<option value="PO3">공공기관</option>
        	<option value="AT4">관광명소</option>
        	<option value="AD5">숙박</option>
        	<option value="FD6">음식점</option>
        	<option value="CE7">카페</option>
        	<option value="HP8">병원</option>
        	<option value="PM9">약국</option>
        </select>
        <div id="map" style="width:500px;height:400px;"></div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (key : value)
                map:null,
                infowindow:null,
                ps:null,
                mark:"",
                markers:[]
            
            };
        },
        methods: {
            placesSearchCB (data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                for (var i=0; i<data.length; i++) {
                    this.displayMarker(data[i]);
                }       
            }
        },
        displayMarker(place) {
            // 마커를 생성하고 지도에 표시합니다
            var marker = new kakao.maps.Marker({
                map: this.map,
                position: new kakao.maps.LatLng(place.y, place.x) ,
                
            });
            this.markers.push(marker);
            
            // 마커에 클릭이벤트를 등록합니다
            kakao.maps.event.addListener(marker, 'click', function() {
                // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
                this.infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
                this.infowindow.open(this.map, marker);
            });
        },
        fnSearch(){
            let self = this;
            for(let i = 0; self.markers.length;i++){
                self.markers[i].setMap(null);
            }
            self.markers= [];
            self.ps.categorySearch(self.mark, self.placesSearchCB, {useMapBounds:true});  
        },
            
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
            // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
            self.infowindow = new kakao.maps.InfoWindow({zIndex:1});
                    
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                    level: 3 // 지도의 확대 레벨
                };  
            
            // 지도를 생성합니다    
            self.map = new kakao.maps.Map(mapContainer, mapOption); 
            
            // 장소 검색 객체를 생성합니다
            self.ps = new kakao.maps.services.Places(self.map); 
            
            // 카테고리로 은행을 검색합니다
        }
        });

    app.mount('#app');
</script>
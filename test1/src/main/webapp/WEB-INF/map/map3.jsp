<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kakao 지도 검색</title>

    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
        integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=82a2d2e3883834b8a2b2cf1015b17f3e&libraries=services"></script>

    <style>
        .map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
        .map_wrap {position:relative;width:100%;height:500px;}
        #menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;
                    padding:5px;overflow-y:auto;background:rgba(255,255,255,0.8);z-index:1;border-radius:10px;}
        #menu_wrap .option {text-align:center;}
        #menu_wrap .option input {margin:5px;}
        #placesList li {list-style:none;}
        #placesList .item {padding:10px;border-bottom:1px solid #ccc;cursor:pointer;}
        #pagination {text-align:center;margin-top:10px;}
        #pagination a {margin:0 5px;}
        #pagination .on {font-weight:bold;color:#777;}
    </style>
</head>
<body>
<div id="app" class="map_wrap">
    <div id="map" style="width:100%;height:100%;"></div>

    <div id="menu_wrap">
        <div class="option">
            <form @submit.prevent="searchPlaces">
                <label>키워드: </label>
                <input type="text" v-model="keyword" placeholder="예: 이태원 맛집" />
                <button type="submit">검색</button>
            </form>
        </div>
        <hr>
        <ul id="placesList">
            <li v-for="(place, i) in places" :key="place.id" class="item"
                @mouseover="showInfoWindow(i)" @mouseout="hideInfoWindow(i)">
                <div class="info">
                    <h5>{{ i + 1 }}. {{ place.place_name }}</h5>
                    <p v-if="place.road_address_name">{{ place.road_address_name }}</p>
                    <p v-else>{{ place.address_name }}</p>
                    <p class="tel">{{ place.phone }}</p>
                </div>
            </li>
        </ul>
        <div id="pagination"></div>
    </div>
</div>

<script>
const app = Vue.createApp({
    data() {
        return {
            map: null,
            ps: null,
            infowindow: null,
            markers: [],
            places: [],
            keyword: "이태원 맛집",
            pagination: null
        };
    },
    methods: {
        // ✅ 검색 실행
        searchPlaces() {
            const keyword = this.keyword.trim();
            if (!keyword) {
                alert("키워드를 입력해주세요!");
                return;
            }
            this.ps.keywordSearch(keyword, this.placesSearchCB);
        },

        // ✅ 검색 콜백
        placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                this.displayPlaces(data);
                this.displayPagination(pagination);
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                alert('검색 결과가 없습니다.');
            } else if (status === kakao.maps.services.Status.ERROR) {
                alert('검색 중 오류가 발생했습니다.');
            }
        },

        // ✅ 지도와 리스트에 결과 표시
        displayPlaces(places) {
            this.clearMarkers();
            this.places = places;
            const bounds = new kakao.maps.LatLngBounds();

            places.forEach((place, i) => {
                const position = new kakao.maps.LatLng(place.y, place.x);
                const marker = this.addMarker(position, i);
                bounds.extend(position);

                kakao.maps.event.addListener(marker, 'mouseover', () => {
                    this.infowindow.setContent(`<div style="padding:5px;">${place.place_name}</div>`);
                    this.infowindow.open(this.map, marker);
                });
                kakao.maps.event.addListener(marker, 'mouseout', () => this.infowindow.close());
            });

            this.map.setBounds(bounds);
        },

        // ✅ 마커 추가
        addMarker(position, idx) {
            const imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
            const imageSize = new kakao.maps.Size(36, 37);
            const imgOptions = {
                spriteSize: new kakao.maps.Size(36, 691),
                spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
                offset: new kakao.maps.Point(13, 37)
            };
            const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
            const marker = new kakao.maps.Marker({ position, image: markerImage });
            marker.setMap(this.map);
            this.markers.push(marker);
            return marker;
        },

        // ✅ 마커 전체 제거
        clearMarkers() {
            this.markers.forEach(marker => marker.setMap(null));
            this.markers = [];
        },

        // ✅ 페이지네이션 표시
        displayPagination(pagination) {
            const paginationEl = document.getElementById('pagination');
            paginationEl.innerHTML = '';
            this.pagination = pagination;

            for (let i = 1; i <= pagination.last; i++) {
                const a = document.createElement('a');
                a.href = "#";
                a.innerHTML = i;
                if (i === pagination.current) {
                    a.className = 'on';
                } else {
                    a.onclick = () => pagination.gotoPage(i);
                }
                paginationEl.appendChild(a);
            }
        },

        // ✅ 리스트에서 마우스 오버 시
        showInfoWindow(i) {
            const place = this.places[i];
            const marker = this.markers[i];
            this.infowindow.setContent(`<div style="padding:5px;">${place.place_name}</div>`);
            this.infowindow.open(this.map, marker);
        },

        // ✅ 리스트에서 마우스 아웃 시
        hideInfoWindow() {
            this.infowindow.close();
        }
    },

    // ✅ Vue mount 후 실행
    mounted() {
        const container = document.getElementById('map');
        const options = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567),
            level: 3
        };
        this.map = new kakao.maps.Map(container, options);
        this.ps = new kakao.maps.services.Places();
        this.infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

        // 초기 검색 실행
        this.searchPlaces();
    }
});

app.mount('#app');
</script>
</body>
</html>

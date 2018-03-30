/**
 * 
 */
var i = 0;
var j = 0;

//왼쪽 메뉴 확장&축소 이벤트
function openNav() {
    var mainNav = document.getElementsByClassName("mainNav"); //확장메뉴
    var content = document.getElementsByClassName("content"); //본문
    var iconBar = document.getElementsByClassName("iconBar"); //축소메뉴
    var logoBg = document.getElementsByClassName("logo-background"); //헤더 로고영역
    var logoFull = document.getElementsByClassName("logo-full"); //확장로고
    var logoMini = document.getElementsByClassName("logo-mini"); //축소로고

    i++; //왼쪽 메뉴버튼 클릭할 때마다 i의 값 1씩 증가하도록

    if (i % 2 == 1) { //클릭수가 홀수이면 축소메뉴 노출
        content[0].style.marginLeft = "60px"; //본문 위치 메뉴너비에 맞춰 옮기기
        iconBar[0].style.width = "60px"; //메뉴 영역 230px에서 60px로 줄이기
        logoBg[0].style.width = "60px"; //로고 영역 230px에서 60px로 줄이기
        mainNav[0].style.width = "0"; //확장메뉴 숨긴다
        logoFull[0].style.width = "0"; //확장로고 숨긴다
        logoMini[0].style.width = "60px"; //축소로고 너비 확보
    }
    else { //클릭수가 짝수이면 확장메뉴 노출
        mainNav[0].style.width = "230px"; //확장메뉴 너비 확보
        content[0].style.marginLeft = "230px"; //본문 위치 메뉴너비에 맞춰 옮기기
        logoBg[0].style.width = "230px"; //확장시 로고영역 확보
        logoFull[0].style.width = "230px"; //확장로고 너비 확보
        logoMini[0].style.width = "0"; //축소로고 숨긴다
    };
};


//오른쪽 메뉴 숨기기&펼치기 이벤트
function openAside() {
	var mainAside = document.getElementById('mainAside'); //오른쪽 메뉴 전체
    var content = document.getElementsByClassName('content'); //본문
    var activeTabNum = null;
    
    j++ //오른쪽 메뉴버튼 클릭할 때마다 j의 값 1씩 증가하도록

    if (j % 2 == 1) { //클릭수가 홀수이면 펼치기
        mainAside.classList.add('mainAside-open'); //클래스 이름 'mainAside-open' 추가
        mainAside.style.width = "330px";
        content[0].style.marginRight = "330px";
        //활성화된 메뉴가 없다면 첫번째 탭 메뉴를 활성화
        if (activeTabNum === null) {
            activeTabNum = 1;
            document.getElementsByClassName("nav-tabs")[0].children[0].classList.add('active');
        };
    } else { //클릭수가 짝수이면 숨기기
        mainAside.classList.remove('mainAside-open'); //클래스 이름 'mainAside-open' 제거
        mainAside.style.width = "0";
        content[0].style.marginRight = "0";
    };
};



$(document).ready(function () {
    //오른쪽 메뉴 탭버튼 제어
    $(".mainAside .nav-tabs > li").on("click", function () {
        //모든 탭버튼 비활성화
        $(".mainAside .nav-tabs > li").removeClass("active");
        //클릭한 탭버튼 활성화
        $(this).addClass("active");
        //현재 활성화된 탭의 번호를 저장
        var idx = $(".mainAside .nav-tabs>li").index(this);
        activeTabNum = idx;
    });
});



//헤더 프로필단추 dropdown메뉴(-)
function openProfileSetting() {
  //1. 프로젝트 화면이면 .rtMenu-profile img display block?
  //  1-1. 클릭할 때마다 dropdown 왔다갔다
  //2. 프로젝트 화면이 아니면 .rtMenu-profile img display none
}
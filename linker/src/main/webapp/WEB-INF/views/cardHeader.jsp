<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LINKER</title>
<style>
	/* 
	html5doctor.com Reset Stylesheet
	v1.6.1
	Last Updated: 2010-09-17
	Author: Richard Clark - http://richclarkdesign.com 
	Twitter: @rich_clark
	*/
	
	html, body, div, span, object, iframe,
	h1, h2, h3, h4, h5, h6, p, blockquote, pre,
	abbr, address, cite, code,
	del, dfn, em, img, ins, kbd, q, samp,
	small, strong, sub, sup, var,
	b, i,
	dl, dt, dd, ol, ul, li,
	fieldset, form, label, legend,
	table, caption, tbody, tfoot, thead, tr, th, td,
	article, aside, canvas, details, figcaption, figure, 
	footer, header, hgroup, menu, nav, section, summary,
	time, mark, audio, video {
	    margin:0;
	    padding:0;
	    border:0;
	    outline:0;
	    font-size:100%;
	    vertical-align:baseline;
	    background:transparent;
	}
	
	body {
	    line-height:1;
	}
	
	article,aside,details,figcaption,figure,
	footer,header,hgroup,menu,nav,section { 
	    display:block;
	}
	
	nav ul {
	    list-style:none;
	}
	
	blockquote, q {
	    quotes:none;
	}
	
	blockquote:before, blockquote:after,
	q:before, q:after {
	    content:'';
	    content:none;
	}
	
	a {
	    margin:0;
	    padding:0;
	    font-size:100%;
	    vertical-align:baseline;
	    background:transparent;
	}
	
	/* change colours to suit your needs */
	ins {
	    background-color:#ff9;
	    color:#000;
	    text-decoration:none;
	}
	
	/* change colours to suit your needs */
	mark {
	    background-color:#ff9;
	    color:#000; 
	    font-style:italic;
	    font-weight:bold;
	}
	
	del {
	    text-decoration: line-through;
	}
	
	abbr[title], dfn[title] {
	    border-bottom:1px dotted;
	    cursor:help;
	}
	
	table {
	    border-collapse:collapse;
	    border-spacing:0;
	}
	
	/* change border colour to suit your needs */
	hr {
	    display:block;
	    height:1px;
	    border:0;   
	    border-top:1px solid #cccccc;
	    margin:1em 0;
	    padding:0;
	}
	
	input, select {
	    vertical-align:middle;
	}
	
	
	/* 여기부터 main CSS */
	html{ height: 100%; }
	
	body {
	    height: 100%;
	    font-family: 'Nanum Barun Gothic', sans-serif;
	    font-weight: 200; /* 글씨 얇게 */
	    font-size: 15pt;
	    /* background-color: #ECF0F5; */
	    position: relative;
	    overflow-y: auto;
	}

	/* 초기화 */
	li {list-style: none;}
	a {text-decoration: none;}
	
	/* 레이아웃 */
	#wrap {
	    height: 100%;
	}
	.container {
	    height: 100%;
	    margin-top: -50px;
	    padding-top: 50px;
	    box-sizing: border-box;
	}
	.mainContainer {
	    position: relative;
	    overflow-y: auto;
	    height: 100%;
	}
	.mainContent {
	    position: absolute;
	    left: 0;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    background: #dddddd;
	}
	
	#header {
	    position: relative;
	    background-color: #FA5883;
	    height: 50px;
	    color: white;
	}
	
	/* 로고 영역~~~~~ */
	.logo-background {
	    display: block;
	    background-color: #fa4575;
	    width: 230px;
	    height: 100%;
	    float: left;
	    text-align: center;
	}
	    /* 메뉴 확장시 로고 */
	.logo-full {
	    position: absolute;
	    color: white;
	    width: 230px;
	    top: 0;
	    left: 0;
	    overflow-x: hidden;
	    transition: 0.2s; /*열었다 닫았다*/
	    z-index: 1;
	}
	    /* 메뉴 축소시 로고 */
	.logo-mini {
	    color: #fa4575;
	    float: left;
	    width: 0px;
	    top: 0;
	    left: 0;
	    overflow-x: hidden;
	    transition: 0.2s; /*열었다 닫았다*/
	    z-index: 1;
	}
	.logo-full img, .logo-mini img { /*로고영역 내 로고img 위치 조정*/
	    margin-top: 14px;
	}
	/* ~~~~~로고 영역 */
	
	
	/* 왼쪽메뉴 단추 */
	.ltMenu-button{
	    float: left;
	    margin: 15px 0 0 15px;
	}
	/* 오른쪽메뉴 설정단추 */
	.rtMenu-button {
	    float: right;
	    margin: 12px;
	}
	/* 오른쪽메뉴 프로필단추*/
	.rtMenu-profile img {
	    float: right;
	    width: 35px;
	    height: 35px;
	    border-radius: 20px;
	    position: absolute;
	    top: 7px;
	    right: 7px;
	}
	/* 헤더 검색창~~~~~ */
	.header-search form {
	    position: relative;
	    width: 230px;
	    float: right;
	    margin-right: 20px;
	}
	.header-search input, .header-search button {
	    border: none;
	    outline: none;
	    border-radius: 2px;
	    margin-top: 7px;
	}
	.header-search input {
	    width: 100%;
	    height: 34px;
	    background: #ff708e;
	    padding-left: 15px;
	    font-size: 12pt;
	    color: white;
	}
	    input[type=text]:focus {/*검색창 활성화할 때 효과*/
	        background-color: white;
	        color: black;
	        transition: all 0.5s ease;
	    }
	.header-search button {
	    height: 26px;
	    width: 26px;
	    position: absolute;
	    top: 5px;
	    right: -8px;
	    background: #FA5883;
	    cursor: pointer;
	}
    .header-search button span {
        color: #F9F0DA;
        font-size: 15px;
        font-weight: bold;
    }
    .header-search button:hover {
        transition: 0.2s;
        background-color: #ff3168;
    }
	/* placeholder 글씨색 바꾸기 - 크롬 4–56*/
	#search::-webkit-input-placeholder { color: #ffa2b6; }
	/* placeholder 글씨색 바꾸기 - IE 10+*/
	#search:-ms-input-placeholder { color: #ffa2b6; }
	/* ~~~~~헤더 검색창 */
	
	
	/* 본문 */
	.content {
	    height: 100%;
	    margin-left: 230px;
	    position: relative;
	    background-color: rgba(156, 156, 156, 0.80);
	}
	
	/* 확장 메뉴(글자)~~~~~ */
	.mainNav {
	    position: absolute;
	    left: 0;
	    top: 0;
	    bottom: 0;
	    width: 230px;
	    z-index: 2;
	    background-color: #232323;
	    overflow: hidden;
	    transition: 0.2s;
	}
	    /* 상단 프로필영역 */
	.profile-area { /*전체 프로필 영역 */
	    top: 0px;
	    height: 50px;
	    margin-top: 10px;
	}
	.profile-img-area {/* 프로필영역 내 이미지 영역*/
	    display: inline;
	    float: left;
	    position: absolute;
	    padding: 0px 10px 0 10px!important;
	}
	.profile-img { /*프로필영역 내 이미지*/
	    width: 42px;
	    border-radius: 100px;
	}
	.profile-nickname-area{ /*프로필영역 내 닉네임 영역*/
	    margin-left: 63px;
	    line-height: 50px;
	}
	.profile-nickname { /*프로필영역 내 닉네임 */
	    font-weight: 400;
	    font-size: 12pt;
	    color: white;
	    float: left;
	}
	    /* 하단 메뉴영역 */
	.mainNav-menu li {
	    height: 45px;
	    line-height: 45px;
	}
	    .mainNav-menu li a {
	        display: block;
	        padding-left: 32px;
	        color: #818181;
	        transition: 0.2s; /*마우스 올릴 때*/
	    }
	        .mainNav-menu li a:hover {
	            height: 45px;
	            font-weight: 300;
	            background-color: #121212;
	            color: #f1f1f1;
	            border-left: solid 5px #fa4575;
	        }
	.mainNav-menu-header {
	    height: 43px !important;
	    padding-left: 15px;
	    margin-top: 10px;
	    background-color: #1b1b1b;
	    font-size: 10pt;
	    font-weight: 400;
	    color: #b7b7b7;
	    line-height: 43px !important;
	}
	/* ~~~~~확장 메뉴(글자) */
	
	
	/* 축소 메뉴(아이콘)~~~~~ */
	.iconBar { /* 축소메뉴 전체 */
	    width: 60px;
	    background-color: #232323;
	    position: absolute;
	    height: 100%;
	    z-index: 1; /* 본문보다 위로 올라오게 */
	}
	.iconBar a { /* 아이콘 */
	    display: inline-block;
	    padding: 10px;
	    margin-left: 5px;
	}
	.iconBar a:nth-child(1){ /* 프로필사진 */
	    margin-left: 0;
	    padding: 12px;
	}
    /* 프로필 사진을 제외한 나머지 메뉴들 */
    .iconBar a:hover:not(:nth-child(1)) {
        background-color: black;
        width: 180px;
        border-left: solid 5px #fa4575;
        border-top-right-radius: 4px;
        border-bottom-right-radius: 4px;
    } .iconBar .profile-img{
        width: 36px;
    }
    /* 메뉴이름 숨김 */
    .iconBar a .icon-menuName {
        display: none;
    }
    /*마우스오버 시 메뉴이름 띄우기*/
    .iconBar a:hover .icon-menuName {
        display: inline-block;
        color: red;
        font-size: 13pt;
        font-weight: 300;
        margin-left: 10px;
        background-color: #121212;
        color: #f1f1f1;
        position: absolute;
        padding: 7px 0 0 10px;
    }
    /* ~~~~~축소 메뉴(아이콘) */


    /* 오른쪽 메뉴~~~~~ */
    .mainAside {
	    width: 0;
	    position: absolute;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    background-color: #232323;
	    overflow-x: hidden;
	    transition: 0.2s; /*열었다 닫았다 할 때*/
	    color: #fff;
	} .nav-tabs-wrap {
	    position: absolute;
	    left: 0;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    overflow: hidden;
	}
	    /* 오른쪽 메뉴 탭 */
	    .nav-tab {
	    position: relative;
	} .nav-tabs > li .nav-tab-btn {
	    float: left;
	    width: 25%;
	} .nav-tabs:after {
	    display: block;
	    content: "";
	    clear: both;
	}
	    /* 오른쪽 메뉴 탭 버튼 */
	    .nav-tabs .nav-tab-btn a {
	    display: block;
	    height: 40px;
	    line-height: 40px;
	    font-size: 11pt;
	    font-weight: 300;
	    color: #ddd;
	    text-align: center;
	    background: #585858;
	} .nav-tabs .active .nav-tab-btn a {
	    background: #232323;
	}
	    /* 오른쪽 메뉴 탭 내용 */
	    .nav-tabs .nav-tab-content {
	    display: none;
	    position: absolute;
	    left: 0;
	    top: 40px;
	    right: 0;
	    bottom: 0;
	} .tab-content-box {
	    width: 100%;
	    height: 100%;
	    overflow-x: hidden;
	    overflow-y: auto;
	    padding: 12px 18px 12px 18px; /**************여기*/
	    box-sizing: border-box;
	}
	    /* 오른쪽 메뉴 열림상태 */
	    .mainAside-open .active .nav-tab-btn a {
	    font-weight: bold;
	} .mainAside-open .active .nav-tab-content {
	    display: block;
	}
	    /************ 이력탭 ************/
	    .pic-list > li {
	    position: relative;
	    margin-left: 38px;
	    padding: 10px 0;
	    border-top: 1px solid #3a3b3b;
	    line-height: 1.5;
	    color: #ddd;
	} .pic-list > li:nth-child(1) {
	    border-top: none;
	}
	    /* 이력목록 > 프로필사진 */
	    .pic-list-writer {
	    position: absolute;
	    left: -38px;
	    top: 12px;
	} .pic-list-writer .profile img {
	    float: left;
	    width: 30px;
	    height: 30px;
	    border-radius: 15px;
	}
	    /* 이력목록 > 내용 */
	    .pic-list-desc {
	    /*margin: 0 24px 0 0;*/
	    word-wrap: break-word; /* 단어 단위로 자동 개행 */
	    font-size: 12pt;
	} .pic-list-desc .name {
	    font-weight: bold;
	    color: #eee;
	    margin-right: 5px;
	}
	    /* 이력목록 > 시간날짜 */
	    .pic-list-datetime {
	    font-size: 12px;
	    color: #818181;
	}
	    /* 더보기 링크 */
	    .show-more {
	    display: none;
	    padding: 12px 12px 12px 0;
	    font-size: 12px;
	    margin-left: 38px;
	    color: #aaa;
	} .show-more:hover {
	    color: #fff;
	}
    /************ 설정탭 ************/
    /* 설정탭 | 팀 멤버 프로필 사진 */
	.all-members {
	    margin: 0 0 13px 10px;
	    width: 294px;
	} .all-members .profile-img {
	        width: 40px;
    }
    /* 설정탭 | 초대 버튼~~~~~ */
	.invite { 
	    -moz-box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	    box-sizing: border-box;
	} .invite-button {
	    font-size: 14px;
	    font-weight: 400;
	    white-space: nowrap;
	    width: 100%;
	    height: 26px;
	    line-height: 25px;
	    display: inline-block;
	    zoom: 1;
	    color: #919191;
	    position: relative;
	    -webkit-transition: border .25s linear, color .25s linear, background-color .25s linear;
	    transition: border .25s linear, color .25s linear, background-color .25s linear;
	    background-color: #3e3e3e;
	    border-color: #8a8a8a;
	    -webkit-box-shadow: 0 3px 0 #4e5b5c;
	    box-shadow: 0 2px 0 #575757;
	} .invite-button:hover {
        background-color: #313131;
    } .invite-button:active {/*버튼 클릭시 효과*/
        top: 3px;
        outline: none;
        -webkit-box-shadow: none;
        box-shadow: none;
    } .invite span{
	    margin-left: 10px;
	}
    /* ~~~~~설정탭 | 초대 버튼 */
    /* 설정탭 | 메뉴~~~~~ */
    .mainAside-tab4-menu {
	    margin-top: 20px;
	} .user-modify a {
	    border-bottom: solid 0.5px #454545;
	    color: #818181;
	    font-size: 18px;
	    padding: 15px 10px 15px 10px;
	    display: block;
	} .user-modify a:hover{
	    background-color: #121212;
	    color: #f1f1f1;
	}
    /* ~~~~~설정탭 | 메뉴 */

	/* ~~~~~오른쪽 메뉴 */
	
	
	.riMenu-dropdown {
	    float: right;
	    position: absolute;
	    top:0;
	    right: 0px;
	    /*overflow: hidden;*/
	}

    .riMenu-dropdown .rtMenu-profile {
        cursor: pointer;
        border: none;
        outline: none;
        color: white;
        padding: 14px 16px;
        background-color: inherit;
        margin: 0;
    }
	.riMenu-dropdown-menu {
	    display: none;
	    position: absolute;
	    top: 50px;
	    right: 0;
	    background-color: #f9f9f9;
	    min-width: 160px;
	    box-shadow: 0px 1px 10px 0px rgba(0,0,0,0.2);
	    z-index: 1;
	}
	
	.riMenu-dropdown-menu a {
	    float: none;
	    color: black;
	    padding: 12px 16px;
	    text-decoration: none;
	    display: block;
	    text-align: left;
	    font-size: 12pt;
	}
	
	    .riMenu-dropdown-menu a:hover {
	        background-color: #ffc0d2;
	    }
	
	.show {
	    display: block;
	}
</style>
</head>
<body>
	<!--header ~ footer까지 감싼다-->
    <div id="wrap">

        <!--header-->
        <header id="header">
            <!--로고부분-->
            <a href="#" class="logo-background">
                <span class="logo-full"><img src="../resources/image/logo.png" width="100" /></span>
                <span class="logo-mini"><img src="../resources/image/logo_mini.png" width="15" /></span>
            </a>
            <!--왼쪽메뉴 단추-->
            <span class="ltMenu-button" style="cursor:pointer" onclick="openNav()">&#9776;</span>
            <!--오른쪽메뉴 설정단추-->
            <span class="rtMenu-button" style="cursor:pointer" onclick="openAside()">
                <img src="../resources/image/icon_gear.png" width="23" />
            </span>
            <!--오른쪽메뉴 프로필단추-->
            <!--<span class="rtMenu-profile" style="cursor:pointer" onclick="openProfileSetting()">
                <img src="../image/profile.png" alt="프로필 사진" />
            </span>-->
            <!--헤더 검색창-->
            <div class="header-search">
                <form>
                    <input type="text" id="search" placeholder="Search" />
                    <button type="submit"><span><i class="fas fa-search"></i></span></button>
                </form>
            </div>
        </header>


        <!--container-->
        <div class="container">
            <div class="mainContainer">
                <div class="mainContent">

                    <!--왼쪽 메뉴(확장메뉴, 축소메뉴)-->
                    <!--확장 메뉴(글자)-->
                    <nav class="mainNav">
                        <!--확장메뉴 | 상단 프로필영역-->
                        <div class="profile-area">
                            <a href="#" class="profile-img-area">
                                <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
                            </a>
                            <div class="profile-nickname-area">
                                <div class="profile-nickname">Holiday</div>
                            </div>
                        </div>
                        <!--확장메뉴 | 하단 메뉴영역-->
                        <ul class="mainNav-menu">
                            <li class="mainNav-menu-header">Main navigation</li>
                            <li><a href="#">Project</a></li>
                            <li><a href="#">ERD</a></li>
                            <li><a href="#">CodeLauncher</a></li>
                            <li><a href="#">Chat</a></li>
                            <li><a href="#">Postman</a></li>
                        </ul>
                    </nav>

                    <!--축소 메뉴(아이콘)-->
                    <nav class="iconBar">
                        <a href="#"><img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" /></a>
                        <!--마우스 오버시 아이콘 색변경 되도록-->
                        <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/u765gerlj/icon_project_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/wbqihhlif/icon_project.png'"><img src="https://s5.postimg.org/wbqihhlif/icon_project.png" width="30" border="0" /><span class="icon-menuName">Project</span></a>
                        <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/beuacuicn/icon_erd_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/6sy64hp3r/icon_erd.png'"><img src="https://s5.postimg.org/6sy64hp3r/icon_erd.png" width="30" border="0" /><span class="icon-menuName">ERD</span></a>
                        <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/a12ngyix3/icon_code_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/8m12s8a47/icon_code.png'"><img src="https://s5.postimg.org/8m12s8a47/icon_code.png" width="30" border="0" /><span class="icon-menuName">CodeLauncher</span></a>
                        <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/aqlftbyw7/icon_chat_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/pmjz0x2l3/icon_chat.png'"><img src="https://s5.postimg.org/pmjz0x2l3/icon_chat.png" width="30" border="0" /><span class="icon-menuName">Chat</span></a>
                        <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/b3ctziwlj/icon_post_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/4pnqw9jzr/icon_post.png'"><img src="https://s5.postimg.org/4pnqw9jzr/icon_post.png" width="30" border="0" /><span class="icon-menuName">Postman</span></a>
                    </nav>

                    

                    <!-- 오른쪽 메뉴 -->
                    <!-- .mainAside-open | 열림 상태 -->
                    <aside id="mainAside" class="mainAside">
                        <div class="nav-tabs-wrap">
                            <ul class="nav-tabs">
                                <!-- .active | 탭 메뉴 활성화 상태 -->
                                <!-- Tab1 | 이력목록 -->
                                <li>
                                    <div class="nav-tab-btn"><a href="#">menu1</a></div>
                                    <div class="nav-tab-content">
                                        <div class="tab-content-box">
                                            <ul class="pic-list">
                                                <li>
                                                    <!-- 작성자 -->
                                                    <div class="pic-list-writer">
                                                        <div class="profile"><img src="https://s18.postimg.org/8blvbj9tl/profile.png" alt="프로필 사진" /></div>
                                                    </div>
                                                    <!-- 이력내용 -->
                                                    <div class="pic-list-desc">
                                                        <span class="name">백다방</span> added Checklist to git 수정된 문서 확인
                                                    </div>
                                                    <!-- 시간/날짜 -->
                                                    <p class="pic-list-datetime">2 hours ago</p>
                                                </li>
                                            </ul>
                                            <!-- 이력 더 보기 -->
                                            <a class="show-more" href="#">View all activity…</a>
                                        </div>
                                    </div>
                                </li><!-- /이력목록 -->

                                <!-- Tab2 | 달성목록 -->
                                <li>
                                    <div class="nav-tab-btn"><a href="#">menu2</a></div>
                                    <div class="nav-tab-content"><div class="tab-content-box">menu2</div></div>
                                </li><!-- /Tab2 | 달성목록 -->
                                
                                <!-- Tab3 | 가리기목록 -->
                                <li>
                                    <div class="nav-tab-btn"><a href="#">menu3</a></div>
                                    <div class="nav-tab-content"><div class="tab-content-box">menu2</div></div>
                                </li><!-- /Tab3 | 가리기목록 -->
                                
                                <!-- Tab4 | 설정 -->
                                <li>
                                    <div class="nav-tab-btn"><a href="#">settings</a></div>
                                    <div class="nav-tab-content">
                                        <div class="tab-content-box">
                                            <!--팀 멤버 프로필 사진-->
                                            <div class="all-members">
                                                <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
                                                <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
                                                <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
                                                <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
                                                <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
                                                <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
                                                <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
                                                <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
                                            </div>
                                            <!--초대 버튼-->
                                            <div class="invite">
                                                <a href="#" class="invite-button">
                                                    <span class="invite-icon"><i class="fas fa-user-plus"></i></span>
                                                    <span>invite</span>
                                                </a>
                                            </div>
                                            <!--메뉴-->
                                            <div class="mainAside-tab4-menu">
                                                <div class="user-modify"><a href="#">회원정보수정</a></div>
                                                <div class="user-modify"><a href="#">팀 정보 수정</a></div>
                                                <div class="user-modify"><a href="#">프로젝트수정</a></div>
                                            </div>
                                        </div>
                                    </div>
                                </li><!-- /Tab4 | 설정 -->

                            </ul>

                        </div>
                    </aside>
                    
                    
                    <!--본문-->
                    <div class="content">
                        <!-- main jsp -->
						<%@include file="cardTest.jsp"%>
                    </div>
                    
                    
                </div>
            </div>
        </div>
        <!--/.container-->
    </div>
    
    
    <script>
        
        //왼쪽 메뉴 확장&축소 이벤트
        var i = 0;
        var j = 0;
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
        var mainAside = document.getElementById('mainAside'); //오른쪽 메뉴 전체
        var content = document.getElementsByClassName('content'); //본문
        var activeTabNum = null;

        function openAside() {
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

        //헤더 프로필단추 dropdown메뉴
        function openProfileSetting() {
            //1. 프로젝트 화면이면 .rtMenu-profile img display block?
            //  1-1. 클릭할 때마다 dropdown 왔다갔다
            //2. 프로젝트 화면이 아니면 .rtMenu-profile img display none
        }

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


    </script>
</body>
</html>

<%-----------------------------------------------------------------------------
 * 파일명칭 : cardModal.jsp	
 * 설    명 : 카드 상세 내용 조회 모달
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/03
------------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LINKER</title>
<!-- CSS -->
<link href="/resources/css/cards/cardModal.css" type="text/css" rel="stylesheet" />
</head>

<body>
	<div id="popupBox">
        <div class="popupCard">
        	<!-- 카드의 상태값이 보관/휴지통일 때 상단bar-->
        	<div class="popCard-banner archive"><p><i class="fas fa-archive"></i> 이 카드는 보관함에 있습니다. 수정이 불가능합니다.</p></div>
        	<div class="popCard-banner hide"><p><i class="fas fa-archive"></i> 이 카드는 휴지통에 있습니다. 조회만 가능합니다.</p></div>
            <!-- 헤더 | 카드 제목 -->
            <header class="cardTitle">
                <span></span>          
                <div class="title-cardTitle">
                	<!--카드 제목 DB에서 가져옴-->
                	<input type="text" class="title-modify" maxlength="20"  onkeydown="enterPress(event); limitMemo(this, 20);"/>
                	<!-- 카드모달 닫기 버튼 -->
            		<div class="popupCardClose">&times;</div>
                	<!-- id값(hidden) -->
                	<p class="card-id-Hidden"></p>
                </div>
                <div class="popupCardUserInfo">
                	<div class="popupCardProfile"></div>
                	<div class="popupcard-info">
	                	<p class="popupCardUserNickname"></p>
	                	<p class="popupCardCdate"></p>
                	</div>
                </div>
                <!-- 카드모달 드롭다운 메뉴 -->
                <div class="popCardMenu">
                	<img class="popCardMenuIcon" src="https://s5.postimg.cc/qx0hjoxmv/588a64e7d06f6719692a2d11.png">
                </div>
            </header>

            <!-- 왼쪽 | 카드 실제 내용 부분-->
            <section>
                <!-- 내용 -->
                <article>
                    <div class="cardContent">
                        <div class="title-content title">
                            <i class="fas fa-align-left"></i><strong>본문</strong>
                        </div>
                        <div class="content-content">
                            <textarea class="content-textarea description" placeholder="본문 추가하기"></textarea>
                            <div class="readMore-box"><button class="readMore">read more</button></div>
                        </div>
                        <div class="content-Btn">
                            <button class="saveBtn description">저장</button>
                            <button class="cancelBtn" onclick="modifyDescriptionCancel()">&times;</button>
                        	<span class="countByte">0</span><p>/10,000byte<p>
                        </div>
                         <div class="warning">
                            <ul class="warningUL">
 	                            <li>저장하지 않은 내용입니다.</li>
                                <li class="viewEdits">편집</li>
                                <li class="saveBtn description">저장</li>
                                <li class="discard" onclick="modifyDescriptionCancel()">삭제</li>
                            </ul>
                        </div>
                        <div class="countByte-warning"><p>제한된 글자수를 넘어 저장할 수 없습니다.</p></div>
                    </div>
                </article>

                <!-- 첨부파일 -->
                <%@include file="cardModalAttach.jsp"%>
                <!-- 댓글작성 -->
                <article>
                    <div class="comment">
                        <div class="title-comment title">
                            <i class="far fa-comment"></i><strong>댓글작성</strong>
                        </div>
                        <div class="comment-content">
                            <textarea class="content-textarea reply create" placeholder="댓글 작성하기"></textarea>
	                        <div class="comment-Btn">
	                        	<button class="saveBtn reply create">저장</button>
	                        	<button class="cancelBtn" onclick="modifyReplyCancel()">&times;</button>
	                        </div>
                        </div>
                    </div>
                </article>
                <!-- 댓글목록 & 이력 -->
                <article>
                    <div class="activity">
                        <div class="title-activity title">
                            <i class="fas fa-list-ul"></i><strong>댓글목록</strong>
                        </div>
                        <div class="activity-content"></div>
                    </div>
                    <!-- 댓글 삭제 모달창 -->
					<div class="closeBoardModal reply">
						<div class="closeBoardModal-content reply">
							<div class="closeBoardModal-title reply">
								<span class="closeTitle reply">Delete comment?</span>
								<span class="closeModal reply">&times;</span>
							</div>
							<div class="closeBoardModal-text reply">
								<p class="closeBoardModal-text reply">
									삭제한 댓글은 되돌릴 수 없습니다. 정말 삭제하시겠습니까?
								</p>
								<button class="closeBoardBtn reply" value="OK">삭제</button>
							</div>
						</div> 
					</div>
					<!-- /close board 모달창  -->
                </article>
            </section>


            <!-- 오른쪽 | 사이드메뉴 -->
            <aside class="popupCard-aside">
                <div><strong>Menu</strong></div>
                <span class="closeModal dropdown">&times;</span>
                <ul>
                    <li><div class="popupCard-aside-archive"><i class="fas fa-archive"></i><p>보관함으로</p></div></li>
                    <li><div class="popupCard-aside-hide"><i class="fas fa-trash-alt"></i><p>휴지통으로</p></div></li>
                    <li><div class="popupCard-aside-sendToCardlist"><i class="fas fa-undo-alt"></i><p>프로젝트로</p></div></li>
                </ul>
            </aside>
        </div>
    </div>
    <div id="#imgModal">
    	<div class="imgModal"></div>
	    <span class="closeModal imageModal">&times;</span>
    </div>
    
</body>

<script src="../../../resources/js/jquery-3.3.1.min.js"></script>
<script src="../../../resources/js/board/cardModal.js" type="text/javascript"></script>
<script src="../../../resources/js/board/cardModalReply.js" type="text/javascript"></script>

</html>
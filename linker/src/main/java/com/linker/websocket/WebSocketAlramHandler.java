package com.linker.websocket;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Repository
public class WebSocketAlramHandler extends TextWebSocketHandler {

	@Inject
	SqlSession session;
	
	//연결이 성사 되고 나서 해야할 일들.
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionEstablished(session);
	}
	
	//웹소켓 서버단으로 메세지가 도착했을때 해주어야할 일들을 정의하는 메소드 입니다.
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TODO Auto-generated method stub
		super.handleTextMessage(session, message);
	}

	//웹 소켓 연결이 종료되고 나서 서버단에서 실행해야할 일들을 정의해주는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		
		super.afterConnectionClosed(session, status);
	}

}

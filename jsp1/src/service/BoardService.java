package service;

import java.util.List;
import java.util.Map;

import dto.Board;

public interface BoardService {
	
	// 게시판 리스트 보기
	List<Board> selectBoardList();
	
	// 한 글보기
	Map<String, String> selectBoard();
	
	// 내용 추가
	int insertBoard();
	
	// 내용 수정
	int updateBoard();
	
	// 내용 삭제
	int deleteBoard();
	
	
}

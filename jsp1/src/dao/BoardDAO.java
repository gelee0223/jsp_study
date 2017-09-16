package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dto.Board;
import dto.Page;

public class BoardDAO {
	
	public List<Board> selectBoardList(Connection con, Map<String, String> pHm, Page p) throws SQLException{
		
		List<Board> boardList = new ArrayList<Board>();
		
		// String sql = "SELECT * FROM board";
		String sql = "SELECT b.*, u.name FROM board as b, user as u"
				      + " WHERE b.writer = u.user_no";
		
		int idx = 0;
		
		if(pHm.get("content") != null) {
			sql += " and b.content like concat('%', ?, '%')";
		}
		
		sql += " limit ?, ?";		// 첫 번째 ?는 시작 index / 두 번째 ?는 갯수 
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		if(pHm.get("content") != null) {
			ps.setString(++idx, pHm.get("content"));
		}
		
		ps.setInt(++idx, p.getStartRow());
		ps.setInt(++idx, p.getRowCnt());
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Board b = new Board();
			b.setbNum(rs.getInt("b_num"));
			b.setTitle(rs.getString("title"));
			b.setWriter(rs.getString("writer"));
			b.setContent(rs.getString("content"));
			b.setRegDate(rs.getString("reg_Date"));
			b.setUserName(rs.getString("name"));
			
			boardList.add(b);
		}
		
		return boardList;
	}

	public int selectBoardCount(Connection con, Map<String, String> pHm, Page p) throws SQLException{
				
		String sql = "SELECT count(1) FROM board as b, user as u"
				      + " WHERE b.writer = u.user_no";
		
		
		if(pHm.get("content") != null) {
			sql += " and b.content like concat('%', ?, '%')";
		}
						
		PreparedStatement ps = con.prepareStatement(sql);
		
		if(pHm.get("content") != null) {
			ps.setString(1, pHm.get("content"));
		}
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			return rs.getInt(1);
		}
		
		return 0;
	}
	
}

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Board;

public class BoardDAO {
	
	public List<Board> selectBoardList(Connection con) throws SQLException{
		
		List<Board> boardList = new ArrayList<Board>();
		
		String sql = "SELECT * FROM board";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Board b = new Board();
			b.setbNum(rs.getInt("b_num"));
			b.setTitle(rs.getString("title"));
			b.setWriter(rs.getString("writer"));
			b.setContent(rs.getString("content"));
			b.setRegDate(rs.getString("reg_Date"));

			boardList.add(b);
		}
		
		return boardList;
	}

}

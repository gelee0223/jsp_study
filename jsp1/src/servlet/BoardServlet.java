package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.Board;
import service.BoardService;
import service.implement.BoardServiceImpl;

// http://raw.githubusercontent.com/cnfree/eclipse/master/decompiler/update/

public class BoardServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private BoardService bs = new BoardServiceImpl();
	private Gson g = new Gson();
	/*
	class User{
		private String name;
		private int age;
		
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}
		
		@Override
		public String toString() {	// 요 녀석이 포인트!!! 하지 않으면, jsp에서도 동일하게 주소를 print
			return "User [name=" + name + ", age=" + age + "]";
		}
		
	}
	*/
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			     throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String command = request.getParameter("command");
		
		if(command == null) {
			Map<String, String> pMap = g.fromJson(request.getReader(), HashMap.class);
			command = pMap.get("command");
		}
		
		if(command.equals("list")) {			
			List<Board> boardList = bs.selectBoardList();
			
			String result = g.toJson(boardList);
			doProcess(response, result);
		}
				
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
				 throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
				
		String command = request.getParameter("command");
		
		if(command.equals("list")) {
			RequestDispatcher rd = request.getRequestDispatcher("/board/board_list.jsp");
			List<Board> boardList = bs.selectBoardList();
			
			request.setAttribute("boardList", boardList);
			rd.forward(request, response);
		}
		
    }
	
	public void doProcess(HttpServletResponse response, String writeStr)
			 throws IOException{
		response.setContentType("text/html; charset = UTF-8");
		PrintWriter out = response.getWriter();
		out.print(writeStr);
	}
	
}

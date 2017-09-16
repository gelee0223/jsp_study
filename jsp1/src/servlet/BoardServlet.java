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
import dto.Page;
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
				
		String param = request.getParameter("param");
		String page  = request.getParameter("page");
		
		Map<String, String> pMap = g.fromJson(param, HashMap.class);
		
		Page p = g.fromJson(page, Page.class);
		
		System.out.println(param + " " + page + " " + pMap);
		
//		String command = request.getParameter("command");
//		String content    = request.getParameter("content");
		
		String command = pMap.get("command");
		String content    = pMap.get("content");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String result = "";
		
		if(command.equals("list")) {			
			if( content != null && content.trim().length() == 1) {
					map.put("error", "한글자 검색은 불가능합니다.");
					
					result = g.toJson(map);
			}
			else {
				List<Board> boardList = bs.selectBoardList(pMap, p);
				map.put("list", boardList);
				map.put("page", p);
				map.put("param", pMap);
				result = g.toJson(map);
			}
		}

		doProcess(response, result);
		
		/*
		if(command == null) {
			Map<String, String> pMap = g.fromJson(request.getReader(), HashMap.class);
			command = pMap.get("command");
			content    = pMap.get("content");
		}
		
		if(command.equals("list")) {			
			if( content != null ) {
				if( content.trim().length() == 1 ) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("error", "한글자 검색은 불가능합니다.");
					
					String result = g.toJson(map);
					doProcess(response, result);
				}
			}
			else {
				List<Board> boardList = bs.selectBoardList();
				
				String result = g.toJson(boardList);
				doProcess(response, result);
			}
		}*/
				
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
				 throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
				
		String command = request.getParameter("command");
		
		if(command.equals("list")) {
			RequestDispatcher rd = request.getRequestDispatcher("/board/board_list.jsp");
			List<Board> boardList = bs.selectBoardList(null, null);
			
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

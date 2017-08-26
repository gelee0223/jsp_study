package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.UserService;
import service.implement.UserServiceImpl;

// http://raw.githubusercontent.com/cnfree/eclipse/master/decompiler/update/

public class UserServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private UserService us = new UserServiceImpl();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			     throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String command = request.getParameter("command");
		
		if(command == null) {
			doProcess(response, "잘못된 요청입니다.");
		}
		else {
			
			if(command.equals("signing")) {
				String id = request.getParameter("id");
				String pwd = request.getParameter("pwd");
				String name = request.getParameter("name");
				String[] hobbies = request.getParameterValues("hobby");
				
				String hobby = "";
				
				for(String h : hobbies) {
					hobby += h + ",";
				}
				
				hobby = hobby.substring(0, hobby.length() - 1);
				
				Map<String, String> hm = new HashMap<String, String>();
				hm.put("id", id);
				hm.put("pwd", pwd);
				hm.put("name", name);
				hm.put("hobby", hobby);
		
				String result = us.insertUser(hm);
				doProcess(response, result);
			}
			else if(command.equals("login")) {
				String id = request.getParameter("id1");
				String pwd = request.getParameter("pwd1");
				
				Map<String, String> hm = new HashMap<String, String>();
				hm.put("id", id);
				hm.put("pwd", pwd);
				
				Map<String, String> resultMap = us.selectUser(hm);
				
				if(resultMap.get("id") != null) {
					HttpSession session = request.getSession();
					session.setAttribute("user", resultMap);
					/*
					session.setAttribute("id", resultMap.get("id"));
					session.setAttribute("user_no", resultMap.get("user_no"));
					session.setAttribute("name", resultMap.get("name"));
					session.setAttribute("hobby", resultMap.get("hobby"));
					*/
				}
				
				doProcess(response, resultMap.get("result"));
			}
			else if(command.equals("logout")) {
				HttpSession session = request.getSession();
				session.invalidate();	// session이 가지고 있는 값을 초기화시킴
				response.sendRedirect("/login.jsp");
			}
			else if(command.equals("delete")) {
				String userNo = request.getParameter("userNo");
				Map<String, String> hm = new HashMap<String, String>();
				hm.put("user_no", userNo);
				
				int rCnt = us.deleteUser(hm);
				String result = "회원탈퇴에 실패하셨습니다.";
				if(rCnt == 1) {
					result = "회원탈퇴에 성공하셨습니다.";
					result += "<script>";
					result += "alert('회원탈퇴에 성공하셨습니다. 방문해 주셔서 감사합니다.');";
					result += "</script>";
				}
				
				doProcess(response, result);
			}
		}
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
				 throws ServletException, IOException {
		
    }
	
	public void doProcess(HttpServletResponse response, String writeStr)
			 throws IOException{
		response.setContentType("text/html; charset = UTF-8");
		PrintWriter out = response.getWriter();
		out.print(writeStr);
	}
	
}

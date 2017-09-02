package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import service.UserService;
import service.implement.UserServiceImpl;

// http://raw.githubusercontent.com/cnfree/eclipse/master/decompiler/update/

public class UserServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private UserService us = new UserServiceImpl();
	private Gson g = new Gson();
	
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
//				String id = request.getParameter("id1");
//				String pwd = request.getParameter("pwd1");
				
//				Map<String, String> hm = new HashMap<String, String>();
//				hm.put("id", id);
//				hm.put("pwd", pwd);
				
				Map<String, String> hm = g.fromJson(request.getParameter("param"), HashMap.class);
				
				Map<String, String> resultMap = us.selectUser(hm);
				
//				String url = "location.href = '/user/login.jsp'";
				String url = "/user/login.jsp";
				
				if(resultMap.get("id") != null) {
					HttpSession session = request.getSession();
					session.setAttribute("user", resultMap);
//					url = "location.href = '/main.jsp'";
					url = "/main.jsp";
					/*
					session.setAttribute("id", resultMap.get("id"));
					session.setAttribute("user_no", resultMap.get("user_no"));
					session.setAttribute("name", resultMap.get("name"));
					session.setAttribute("hobby", resultMap.get("hobby"));
					*/
				}
//				String result = "<script>";
//				result += "alert('" + resultMap.get("result") + "');";
//				result += url;
//				result += "</script>";
				
				resultMap.put("url", url);
				
				String result = g.toJson(resultMap);
				
				doProcess(response, result);
			}
			else if(command.equals("logout")) {
				HttpSession session = request.getSession();
				session.invalidate();	// session이 가지고 있는 값을 초기화시킴
				response.sendRedirect("/user/login.jsp");
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
			else if(command.equals("update")) {

				// HttpSession session = request.getSession();
				
				String id = request.getParameter("id");
				String pwd = request.getParameter("pwd");
				String name = request.getParameter("name");
				String[] hobbies = request.getParameterValues("hobby");
				String user_no = request.getParameter("userNo");
				// String user_no = ((Map<String, String>)session.getAttribute("user")).get("user_no");
				
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
				hm.put("user_no", user_no);
		
				int rCnt = us.updateUser(hm);
				
				String result = "회원 정보 수정이 실패하였습니다. 다시 시도해 보세요.";
				
				if(rCnt == 1) {
					result = "회원 정보 수정이 완료되었습니다.";
					
					HttpSession session = request.getSession();
					session.setAttribute("user", hm);
				}
				doProcess(response, result);
			}
			else if(command.equals("list")) {
				Map<String, String> hm = new HashMap<String, String>();
				List<Map<String, String>> userList = us.selectUserList(hm);
				
				String result = "<table border='1'>";
				
				result += "<td align='center'>" + "No." + "</td>";
				result += "<td align='center'>" + "이름" + "</td>";
				result += "<td align='center'>" + "아이디" + "</td>";
				result += "<td align='center'>" + "취미" + "</td>";
				 
				for(Map<String, String>m : userList) {
					result += "<tr>";
					result += "<td>" + m.get("user_no") + "</td>";
					result += "<td>" + m.get("name") + "</td>";
					result += "<td>" + m.get("id") + "</td>";
					result += "<td>" + m.get("hobby") + "</td>";
					result += "</tr>";
				}
				result += "</table>";
				doProcess(response, result);
			}
		}
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
				 throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		String param = request.getParameter("param");
		Map<String, String> hm = g.fromJson(param, HashMap.class);
		
		System.out.println(hm.get("id"));
		System.out.println(hm.get("pwd"));
		
		String id = hm.get("id");
		String pwd = hm.get("pwd");
		
		String msg = "없는 아이디입니다.";
		
		if(id.equals("red")) {
			if(pwd.equals("red")) {
				msg = "로그인에 성공하셨습니다.";
			}
			else {
				msg = "비밀번호가 틀렸습니다.";
			}
		}
		
		Map<String, String> rHm = new HashMap<String, String>();
		rHm.put("msg", msg);
		
		String result = g.toJson(rHm);
		
		doProcess(response, result);
    }
	
	public void doProcess(HttpServletResponse response, String writeStr)
			 throws IOException{
		response.setContentType("text/html; charset = UTF-8");
		PrintWriter out = response.getWriter();
		out.print(writeStr);
	}
	
}

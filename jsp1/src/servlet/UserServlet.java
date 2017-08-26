package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.DBConnector;
import service.UserService;
import service.implement.UserServiceImpl;

// http://raw.githubusercontent.com/cnfree/eclipse/master/decompiler/update/

public class UserServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private UserService us = new UserServiceImpl();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			     throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
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

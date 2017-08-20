package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// http://raw.githubusercontent.com/cnfree/eclipse/master/decompiler/update/

public class TestServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			     throws ServletException, IOException {
		System.out.println("두포스트 호출했네요~~" + request.getParameterMap());
		PrintWriter out = response.getWriter();
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
				 throws ServletException, IOException {
		
		/*
		System.out.println("두겟 호출했네요~~" + request.getParameterMap());
		// PrintWriter out = response.getWriter();
		// out.println("두겟 호출했네요~~" + request.getParameterMap());
		String writeStr = "두겟 호출했네요~~" + request.getParameterMap() + "<br>";
		doProcess(response, writeStr);
		
//		doProcess(response, request.getParameter("a") + "<br>");
//		doProcess(response, request.getParameter("b") + "<br>");
//		doProcess(response, request.getParameter("c") + "<br>");
		*/
		
		Map<String, String[]> m = request.getParameterMap();
		Iterator<String> it = m.keySet().iterator();
		
		String result = "두겟 호출했네요~~" + "<br>";
		
		while(it.hasNext()) {
			String key = it.next();
			result += key + " : " + request.getParameter(key) + "<br>";
		}
		
		doProcess(response, result);
    }
	
	public void doProcess(HttpServletResponse response, String writeStr)
			 throws IOException{
		response.setContentType("text/html; charset = UTF-8");
		PrintWriter out = response.getWriter();
		out.print(writeStr);
	}
	
}

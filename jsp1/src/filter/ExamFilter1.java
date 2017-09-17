package filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

public class ExamFilter1 implements Filter{

	Gson g = new Gson();
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("utf-8");
		res.setContentType("text/html;charset=utf-8");
		HttpServletRequest request = (HttpServletRequest)req;
		HttpSession session = request.getSession();
		
		String param = request.getParameter("param");
		Map<String, String> hm = null;
		
		if(param ==null) {
			hm = g.fromJson(param, HashMap.class);
			
			hm.put("id", request.getParameter("id"));
			hm.put("pwd", request.getParameter("pwd"));
			session.setAttribute("user", hm);
			
		}
		
		System.out.println("doFilter1" + fc);
		System.out.println(request.getRequestURL().toString());
		
		fc.doFilter(req, res);
	}

	@Override
	public void init(FilterConfig fc) throws ServletException {
		// TODO Auto-generated method stub
//		context = fc.getServeletCon
	}

}

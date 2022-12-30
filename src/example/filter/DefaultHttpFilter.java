package example.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class DefaultHttpFilter implements Filter {

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		String query = request.getParameter("query");
		System.out.println("DefaultHttpFilter doFilter query : " + query);
		
		HttpServletRequest r = (HttpServletRequest) request;
		
		System.out.println("sessionId : " + r.getSession().getId());
		
		chain.doFilter(request, response);
		/*
		response.getWriter().write("Spring Test");
		response.getWriter().flush();
		response.getWriter().close();
		*/
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("DefaultHttpFilter 생성되고 init 메소드가 호출됨.");
	}

}

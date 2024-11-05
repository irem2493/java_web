package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/detail")
public class DetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setCharacterEncoding("utf-8");
		
		String dogijungNo = request.getParameter("dogijungNo");
		String myongChing = request.getParameter("myongChing");
		String myongChingHannum  = request.getParameter("myongChingHannum");
		String content = request.getParameter("content");
		String jijungDate = request.getParameter("jijungDate");
		String fileurl1 = request.getParameter("fileurl1");
		String fileurl2 = request.getParameter("fileurl2");
		String fileurl3 = request.getParameter("fileurl3");
		String utmkX = request.getParameter("utmkX");
		String utmkY = request.getParameter("utmkY");
		
		
		request.getRequestDispatcher("detail.jsp?dogijungNo="+dogijungNo+
				"myongChing="+myongChing+
				"myongChingHannum="+myongChingHannum+
				"content="+content+
				"jijungDate="+jijungDate+
				"fileurl1="+fileurl1+
				"fileurl2="+fileurl2+
				"fileurl3="+fileurl3+
				"utmkX="+utmkX+
				"utmkY="+utmkY
				).forward(request, response);
	}
}

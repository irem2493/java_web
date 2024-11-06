package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReplyDao;
import dto.Reply;


@WebServlet("/reply")
public class ReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ReplyDao rDao = new ReplyDao();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//index에서 댓글 창으로 이동
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		
		String bno = request.getParameter("bno");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String createDate = request.getParameter("createDate");
		String uid = request.getParameter("uid");
		
		
		request.getRequestDispatcher("replyReg.jsp?bno="+bno+
				"title="+title+
				"contents="+contents+
				"createDate="+createDate+
				"uid="+uid
				).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		
		String mode = request.getParameter("mode");
		if(mode.equals("regRp")) registerReply(request, response);
	}
	void registerReply(HttpServletRequest request, HttpServletResponse response) {
		Reply reply = new Reply();
		int bno=Integer.parseInt(request.getParameter("bno").split("t")[0]);
		reply.setBno(bno);
		reply.setUid(request.getParameter("uid"));
		reply.setRcontents(request.getParameter("rcontents"));
		System.out.println(reply);
		int presult = rDao.insertReply(reply);
		if(presult > 0) {
			request.setAttribute("presult", presult);
			try {
				request.getRequestDispatcher("replyReg.jsp?presult="+presult+"&bno="+bno).forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}

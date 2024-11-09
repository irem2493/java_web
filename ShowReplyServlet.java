package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReplyDao;
import dto.Reply;


@WebServlet("/showReply")
public class ShowReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	ReplyDao rDao = new ReplyDao();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		
		String mode = request.getParameter("mode");
        if(mode != null) {
	        if(mode.equals("pdel")) deleteReply(request,response);
        }
        else {
		int bno = Integer.parseInt(request.getParameter("bno"));
		ArrayList<Reply> rList = rDao.selectReply(bno);
		
		PrintWriter out = response.getWriter();
        
	     // JSON 배열을 만들기
	        StringBuilder jsonResponse = new StringBuilder();
	        jsonResponse.append("[");

	        for (int i = 0; i < rList.size(); i++) {
	            Reply reply = rList.get(i);
	            jsonResponse.append(reply.toJson());
	            if (i < rList.size() - 1) {
	                jsonResponse.append(",");
	            }
	        }

	        jsonResponse.append("]");

	        System.out.println(jsonResponse.toString());
	        // 클라이언트에 JSON 데이터 전송
	        out.write(jsonResponse.toString());
        }
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	//댓글 삭제
	void deleteReply(HttpServletRequest request, HttpServletResponse response) {
		//System.out.println(request.getParameter("bno"));
		int bno=Integer.parseInt(request.getParameter("bno"));
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String createDate = request.getParameter("createDate");
		System.out.println(createDate);
		int pdel_result = rDao.deleteReply(Integer.parseInt(request.getParameter("rno")),request.getParameter("uid"));
		if(pdel_result > 0) {
			request.setAttribute("pdel_result", pdel_result);
			try {
				request.getRequestDispatcher("replyReg.jsp?pdel_result="+pdel_result+"&bno="+bno
						+"&title="+title+"&contents="+contents
						+"&createDate="+createDate).forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}

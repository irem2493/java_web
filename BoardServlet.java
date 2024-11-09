package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BoardDao;
import dao.ReplyDao;
import dto.Board;


@WebServlet("/boardManage")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	BoardDao bDao = new BoardDao();
	   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		//게시판 보기
		ArrayList<Board> bList = bDao.selectBoard();
		PrintWriter out = response.getWriter();
        
     // JSON 배열을 만들기
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("[");

        for (int i = 0; i < bList.size(); i++) {
            Board board = bList.get(i);
            jsonResponse.append(board.toJson());
            if (i < bList.size() - 1) {
                jsonResponse.append(",");
            }
        }

        jsonResponse.append("]");

        // 클라이언트에 JSON 데이터 전송
        out.write(jsonResponse.toString());
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		String mode = request.getParameter("mode");
		if(mode.equals("breg")) registerBoard(request, response);
		else if(mode.equals("bdel")) deleteBoard(request, response);
		
	}
	
	//게시판 등록
	void registerBoard(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		Board board = new Board();
		board.setUid((String)session.getAttribute("userId"));
		board.setTitle(request.getParameter("btitle"));
		board.setContents(request.getParameter("bcontent"));
		int bresult = bDao.insertBoard(board);
		if(bresult > 0) {
			request.setAttribute("bresult", bresult);
			try {
				request.getRequestDispatcher("boardReg.jsp?bresult="+bresult).forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	//게시글 삭제
	void deleteBoard(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		int bresult_del = 0;
		//댓글 삭제(댓글이 있는지 없는지 확인하기)
		ReplyDao rDao = new ReplyDao();
		int pCnt = rDao.selectReplyCnt(Integer.parseInt(request.getParameter("bno")));
		if(pCnt > 0)rDao.deleteReplys(Integer.parseInt(request.getParameter("bno")));
		System.out.println(pCnt > 0);
		//게시글 삭제
		bresult_del = bDao.deleteBoard((String)session.getAttribute("userId"), Integer.parseInt(request.getParameter("bno")));
		//System.out.println(bresult_del);
		if(bresult_del > 0) {
			request.setAttribute("bresult_del", bresult_del);
			try {
				request.getRequestDispatcher("boardReg.jsp?bresult_del="+bresult_del).forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}

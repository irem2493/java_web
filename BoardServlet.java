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
}

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
import dto.Pager;


@WebServlet("/boardManage")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	BoardDao bDao = new BoardDao();
	   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		//게시판 보기
		int bCnt = bDao.getBListCnt();
		System.out.println(request.getParameter("pageNum")+"---pageNum");
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		Pager pager = new Pager(pageNum, bCnt, 3, 10);
		ArrayList<Board> bList = bDao.selectBoard(pager.getStartRow()-1, pager.getPageSize());
		PrintWriter out = response.getWriter();
        
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{");  // JSON 객체 시작
        jsonResponse.append("\"totalCount\": ").append(bCnt).append(","); 
        jsonResponse.append("\"bList\":[");

        for (int i = 0; i < bList.size(); i++) {
            Board board = bList.get(i);
            jsonResponse.append(board.toJson());
            if (i < bList.size() - 1) {
                jsonResponse.append(",");
            }
        }

        jsonResponse.append("],");
        
        // Pager 데이터 포함
        jsonResponse.append("\"pager\": ");
        jsonResponse.append(pager.toJson());  // Pager 객체를 JSON으로 변환
        
        jsonResponse.append("}");  // JSON 객체 끝
        
        // 클라이언트에 JSON 데이터 전송
        out = response.getWriter();
        out.write(jsonResponse.toString());
        out.flush();
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		String mode = request.getParameter("mode");
		if(mode.equals("breg")) registerBoard(request, response);
		else if(mode.equals("bdel")) deleteBoard(request, response);
		else if(mode.equals("bupd")) updateBoard(request, response);
		
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
	
	//게시글 수정
	void updateBoard(HttpServletRequest request, HttpServletResponse response) {
		int bno=Integer.parseInt(request.getParameter("bno"));
		String uid = request.getParameter("uid");
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String createDate = request.getParameter("craeteDate");
		
		Board board = new Board();
		board.setBno(bno);
		board.setTitle(title);
		board.setContents(contents);
		board.setUid(uid);
		//System.out.println(createDate+"-------");
		board.setCreate_date(Date.valueOf(createDate));
		int bresult_upd = bDao.updateBoard(board);
		if(bresult_upd > 0) {
			request.setAttribute("bresult_upd", bresult_upd);
			System.out.println("게시글 수정 성공");
			try {
				request.getRequestDispatcher("replyReg.jsp?bresult_upd="+bresult_upd+
						"&bno="+bno+"&title="+title+"&contents="+contents+"&createDate="+createDate+"&uid="+uid).forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}else {
			System.out.println(board);
			System.out.println("게시글 수정 실패");
		}
		
	}
}

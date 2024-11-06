package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDao;
import dto.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UserDao uDao = new UserDao();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		
		String mode = request.getParameter("mode");
		if(mode.equals("reg")) checkId(request, response);
		
	}
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		String mode = request.getParameter("mode");
		if(mode.equals("reg")) join(request, response);
		else if(mode.equals("login")) login(request, response);
		
	}
	
	//아이디 중복 체크
	void checkId(HttpServletRequest request, HttpServletResponse response) {

		String id = request.getParameter("id");
		PrintWriter out;
		try {
			out = response.getWriter();
			UserDao uDao = new UserDao();
			int count = uDao.checkId(id);
			System.out.println(count);
			if(!id.equals("")) {
				if(count > 0) out.print("이미 사용 중인 아이디입니다.");
				else out.print("사용할 수 있는 아이디입니다.");
			}else out.print("아이디를 입력해주세요.");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	//회원가입
	void join(HttpServletRequest request, HttpServletResponse response) {
		String userId = request.getParameter("id");
		String userPw = request.getParameter("pw");
		
		System.out.println(userId);
		System.out.println(userPw);
		
		User user = new User(userId, userPw);
		System.out.println(user);
		
		
		boolean joinYN = uDao.insertUser(user);
		if(joinYN) {
			request.setAttribute("joinYN", joinYN);
			try {
				request.getRequestDispatcher("join.jsp?joinYN="+joinYN).forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			};
		}
	}
	
	//로그인
	void login(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		User user = new User(userId, userPw);
		boolean loginYN = uDao.login(user);
		session.setAttribute("userId", userId);
		session.setAttribute("loginYN", loginYN);
		
		if(loginYN) {
			try {
				response.getWriter().write("success");
			} catch (IOException e) {
				e.printStackTrace();
			}
	    } else {
	        try {
				response.getWriter().write("fail");
			} catch (IOException e) {
				e.printStackTrace();
			}
	    }
	}
}

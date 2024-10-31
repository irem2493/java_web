package servlets;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;
import dto.Member;


@WebServlet("/manager")
public class ManagerMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    MemberDao mDao = new MemberDao();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		String mode = request.getParameter("mode");
		System.out.println(mode);
		if(mode.equals("reg")) regMember(request,response);
		else if(mode.equals("mod")) modMember(request,response);
	}
	
	void regMember(HttpServletRequest request, HttpServletResponse response){
		Member member = new Member();
		Integer custno = Integer.parseInt(request.getParameter("custno"));
		String custname = request.getParameter("custname");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
		String joindate = request.getParameter("joindate"); 
		member.setJoindate(Date.valueOf(joindate));
		//char grade = request.getParameter("grade").toCharArray()[0];

		String city = request.getParameter("city");
		member.setCustno(custno);
		member.setCustname(custname);
		member.setPhone(phone);
		member.setAddress(address);
		
		member.setGrade(request.getParameter("grade"));
		member.setCity(city);

		boolean regYN = mDao.registerMember(member);
		System.out.println(regYN);
		request.setAttribute("regYN", regYN);
		request.setAttribute("member", member);
		try {
			request.getRequestDispatcher("memberReg.jsp").forward(request, response);
		} catch (IOException | ServletException e) {
			e.printStackTrace();
		}
	}
	
	void modMember(HttpServletRequest request, HttpServletResponse response) {
		Member member = new Member();
		Integer custno = Integer.parseInt(request.getParameter("custno"));
		String custname = request.getParameter("custname");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
		String joindate = request.getParameter("joindate"); 
		member.setJoindate(Date.valueOf(joindate));
		//char grade = request.getParameter("grade").toCharArray()[0];

		String city = request.getParameter("city");
		member.setCustno(custno);
		member.setCustname(custname);
		member.setPhone(phone);
		member.setAddress(address);
		
		member.setGrade(request.getParameter("grade"));
		member.setCity(city);
		System.out.println(member);
		boolean modYN = mDao.modifyMember(member);
		System.out.println(modYN);
		request.setAttribute("modYN", modYN);
		try {
			response.sendRedirect("memberReg.jsp?custno="+custno);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

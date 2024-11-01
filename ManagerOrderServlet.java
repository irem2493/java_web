package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderDao;
import dto.Order;


@WebServlet("/manager")
public class ManagerOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    OrderDao oDao = new OrderDao();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		response.setContentType("utf-8");
		String mode = request.getParameter("mode");
		System.out.println(mode);
		if(mode.equals("reg")) regOrder(request,response);
		
	}
	void regOrder(HttpServletRequest request, HttpServletResponse response) {
		Order order = new Order();
		order.setOrderno(request.getParameter("orderno"));
		order.setShopno(request.getParameter("shopno"));
		order.setOrderdate(request.getParameter("orderdate"));
		order.setPcode(request.getParameter("pcode"));
		order.setAmount(Integer.parseInt(request.getParameter("amount")));
		boolean regYN = oDao.insertOrder(order);
		request.setAttribute("regYN",regYN );
		try {
			request.getRequestDispatcher("regOrder.jsp").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

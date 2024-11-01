package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DBPKG.DBcon;
import dto.Order;

public class OrderDao {
	Connection con = DBcon.getConnection();
	
	//번호 조회
	public int returnNum() {
		int result = 0;
		String query = "SELECT MAX(orderno) lastNum FROM tbl_order_202101;";
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			rs.next();
			result = rs.getInt("lastNum");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	//주문등록
	public boolean insertOrder(Order order) {
		String query="INSERT INTO tbl_order_202101(orderno, shopno, orderdate, pcode, amount) VALUES (?, ?, ?, ?, ?);";
		int result = 0;
		boolean regYN = false;
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, order.getOrderno());
			pstmt.setString(2,order.getShopno());
			pstmt.setString(3, order.getOrderdate());
			pstmt.setString(4, order.getPcode());
			pstmt.setInt(5, order.getAmount());
			result= pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(result > 0) {
			System.out.println("주문 등록 성공");
			regYN = true;
		}
		else System.out.println("주문 등록 실패");
		return regYN;
	}
	
	//전체 주문 조회
	public List<Order> selectOrders(){
		List<Order> oList = new ArrayList<>();
		String query = "SELECT o.shopno, s.shopname, o.orderno, o.orderdate, o.pcode, p.pname, o.amount, p.cost,"
				+ "p.cost * o.amount AS custprice,  format(p.cost * o.amount-(p.cost * o.amount * s.discount/100),'0') AS disPrice "
				+ "FROM tbl_order_202101 o, tbl_shop_202101 s, tbl_product_202101 p "
				+ "WHERE o.shopno = s.shopno AND o.pcode = p.pcode ORDER BY o.orderno;";
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				Order o = new Order();
				o.setShopno(rs.getString("shopno"));
				o.setShopname(rs.getString("shopname"));
				o.setOrderdate(rs.getString("orderdate"));
				o.setOrderno(rs.getString("orderno"));
				o.setPcode(rs.getString("pcode"));
				o.setPname(rs.getString("pname"));
				o.setAmount(rs.getInt("amount"));
				o.setPcost(rs.getInt("cost"));
				o.setCustprice(rs.getInt("custprice"));
				String s_disPrice = rs.getString("disPrice").replace(",","");
				int disPrice = Integer.parseInt(s_disPrice);
				o.setDisPrice(disPrice);
				oList.add(o);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return oList;
	}
	
	//점포별 주문 조회
	public List<Order> selectShopOrders(){
		List<Order> sList = new ArrayList<>();
		String query = "SELECT s.shopno, o.pcode, p.pname, SUM(o.amount) amount "
				+ "FROM tbl_shop_202101 s, tbl_order_202101 o, tbl_product_202101 p "
				+ "WHERE o.shopno = s.shopno AND o.pcode = p.pcode "
				+ "GROUP BY s.shopno, p.pcode, p.pname; ";
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				Order o = new Order();
				o.setShopno(rs.getString("shopno"));
				o.setPcode(rs.getString("pcode"));
				o.setPname(rs.getString("pname"));
				o.setAmount(rs.getInt("amount"));
				sList.add(o);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sList;
	}
}

package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DBPKG.DBcon;
import dto.Product;

public class ProductDao {
	Connection con = DBcon.getConnection();
	//제품 코드 조회
	public List<Product> selectProductCode(){
		List<Product> pList = new ArrayList<>();
		String query="SELECT pcode, pname, cost, format(cost-cost*(10/100),'0') dten, format(cost-cost*(15/100),'0') dfiften "
				+"FROM tbl_product_202101;";
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				Product p = new Product();
				p.setPcode(rs.getString("pcode"));
				p.setPname(rs.getString("pname"));
				p.setCost(rs.getInt("cost"));
				String s_dten = rs.getString("dten").replace(",","");
				int dten = Integer.parseInt(s_dten);
				p.setDten(dten);
				String s_dfiften = rs.getString("dfiften").replace(",","");
				int dfiften = Integer.parseInt(s_dfiften);
				p.setDfiften(dfiften);
				System.out.println(p);
				pList.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pList;
	}
}

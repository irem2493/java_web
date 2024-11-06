package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBcon.DBcon;
import dto.User;

public class UserDao {
Connection con = DBcon.getConnection();
	
	public int checkId(String id){
		int count = 0;
		String query = "SELECT COUNT(uid) count FROM userTable WHERE uid=?;";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt("count");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
	public boolean insertUser(User uDto) {
		String query="INSERT INTO userTable (uno, uid, upw, join_date) VALUES (uno+1, ?, ?, NOW());";
		int result = 0;
		boolean insertYN = false;
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, uDto.getUid());
			pstmt.setString(2, uDto.getUpw());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(result > 0) {
			System.out.println("등록성공");
			insertYN = true;
		}else System.out.println("등록 실패");
		return insertYN;
	}
	
	public boolean login(User uDto) {
		System.out.println(uDto);
		String query = "SELECT COUNT(*) count FROM userTable WHERE uid=? AND upw=?;";
		int count = 0;
		boolean loginYN = false;
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, uDto.getUid());
			pstmt.setString(2, uDto.getUpw());
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt("count");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(count > 0) {
			System.out.println("로그인 성공");
			loginYN = true;
		}else System.out.println("로그인 실패");
		return loginYN;
	}
}

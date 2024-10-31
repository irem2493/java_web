package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import DBPKG.DBcon;
import dto.Member;

public class MemberDao {
	Connection conn = DBcon.getConnection();	
	
	//번호
	public int returnNum() {
		int result = 0;
		String query = "SELECT MAX(custno) lastNum FROM member_tbl_02;";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			rs.next();
			result = rs.getInt("lastNum");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//등록
	public boolean registerMember(Member member) {
		String query = "INSERT INTO member_tbl_02 VALUES(?,?,?,?,?,?,?);";
		int result = 0;
		boolean regYN = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, member.getCustno());
			pstmt.setString(2, member.getCustname());
			pstmt.setString(3, member.getPhone());
			pstmt.setString(4, member.getAddress());
			
			java.util.Date date = member.getJoindate();
			java.sql.Date joinDate = new java.sql.Date(date.getTime());
			pstmt.setDate(5, joinDate);
			
			pstmt.setString(6, String.valueOf(member.getGrade()));
			pstmt.setString(7, member.getCity());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(result > 0) {
			regYN = true;
			System.out.println("멤버 정보 등록 완료");
		}
		else System.out.println("멤버 정보 등록 실패");
		return regYN;
	}
	
	//조회
	public List<Member> showMembers(){
		List<Member> mList = new ArrayList<>();
		String query = "SELECT * FROM member_tbl_02";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				Member m = new Member();
				m.setCustno(rs.getInt("custno"));
				m.setCustname(rs.getString("custname"));
				m.setPhone(rs.getString("phone"));
				m.setAddress(rs.getString("address"));
				m.setJoindate(rs.getDate("joindate"));
				//m.setGrade(rs.getString("grade").charAt(0));
				m.setGrade(rs.getString("grade"));
				m.setCity(rs.getString("city"));
				mList.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return mList;
	}
	//번호 조회
	public Member showMember(int custno) {
		String query = "SELECT * FROM member_tbl_02 WHERE custno=?";
		Member m = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, custno);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			m = new Member();
			m.setCustno(custno);
			m.setCustname(rs.getString("custname"));
			m.setPhone(rs.getString("phone"));
			m.setAddress(rs.getString("address"));
			m.setJoindate(rs.getDate("joindate"));
			m.setGrade(rs.getString("grade"));
			m.setCity(rs.getString("city"));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return m;
	}
	
	//수정
	public boolean modifyMember(Member member) {
		boolean modYN = false;
		String query = "UPDATE member_tbl_02 SET custname=?, phone=?, address=?, joindate=?, grade=?, city=?  WHERE custno=?;";
		int result = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, member.getCustname());
			pstmt.setString(2, member.getPhone());
			pstmt.setString(3, member.getAddress());
			java.util.Date date = member.getJoindate();
			java.sql.Date joinDate = new java.sql.Date(date.getTime());
			pstmt.setDate(4, joinDate);
			pstmt.setString(5, member.getGrade());
			pstmt.setString(6, member.getCity());
			pstmt.setInt(7, member.getCustno());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(result > 0) {
			modYN = true;
			System.out.println("수정 성공");
		}
		else System.out.println("수정 실패");
		return modYN;
	}
	
	//매출 조회
	public List<Member> showSales() {
		List<Member> mList = new ArrayList<>();
		String query="SELECT m.custno, m.custname, m.grade, SUM(price) sal "
				+ "FROM member_tbl_02 m, money_tbl_02 n "
				+ "WHERE m.custno = n.custno "
				+ "group BY custno "
				+ "ORDER BY sal desc;";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next()) {
				Member m = new Member();
				m.setCustno(rs.getInt("custno"));
				m.setCustname(rs.getString("custname"));
				m.setGrade(rs.getString("grade"));
				m.setSal(rs.getInt("sal"));
				mList.add(m);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mList;
		
	}
}

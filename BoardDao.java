package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import DBcon.DBcon;
import dto.Board;

public class BoardDao {
	Connection conn = DBcon.getConnection();

    public ArrayList<Board> selectBoard(int startRow, int pageSize) {
    	System.out.println(startRow+", "+pageSize);
        String query = "SELECT bno, title, contents, uid, DATE(create_date) create_date FROM boardTable "
        		+ "LIMIT ?,?;";
        ArrayList<Board> boardList = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, pageSize);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
            	Board boardDTO= new Board();
            	boardDTO.setTitle(rs.getString("title"));
            	boardDTO.setContents(rs.getString("contents"));
            	boardDTO.setUid(rs.getString("uid"));
            	boardDTO.setBno(rs.getInt("bno"));
            	boardDTO.setCreate_date(rs.getDate("create_date"));
                boardList.add(boardDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return boardList;
    }
    
    public int getBListCnt() {
    	String query="SELECT COUNT(*) cnt FROM boardTable;";
    	int count = 0;
    	try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			rs.next();
			count = rs.getInt("cnt");
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	return count;
    }

    public Board selectBoardContents(int bno){
        String query = "SELECT bno, title, contents, uid, DATE(create_date) create_date FROM boardTable WHERE bno = ?;";
        Board boardDTO = null;
        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1,bno);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                boardDTO = new Board();
                boardDTO.setTitle(rs.getString("title"));
                boardDTO.setUid(rs.getString("uid"));
                boardDTO.setBno(rs.getInt("bno"));
                boardDTO.setContents(rs.getString("contents"));
                boardDTO.setCreate_date(rs.getDate("create_date"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return boardDTO;
    }

    public int insertBoard(Board boardDTO){
        int result = 0;
        String query = "INSERT INTO boardTable(bno, uid, title, contents, create_date) VALUES(NULL, ?,?,?,NOW());";

        try {
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, boardDTO.getUid());
            stmt.setString(2, boardDTO.getTitle());
            stmt.setString(3,boardDTO.getContents());
            result = stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }

    //게시물 내용 수정
    public int updateBoard(Board board){
        int result = 0;
        String query = "UPDATE boardtable SET title = ?, contents = ?, modify_date = NOW() WHERE uid = ? and bno = ?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, board.getTitle());
            pstmt.setString(2, board.getContents());
            pstmt.setString(3, board.getUid());
            pstmt.setInt(4, board.getBno());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    //게시판 내용 삭제
    public int deleteBoard(String uid, int bno) {
        int result = 0;
        String query = "DELETE FROM boardtable WHERE uid = ? and bno = ?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, uid);
            pstmt.setInt(2, bno);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}

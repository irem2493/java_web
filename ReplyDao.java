package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import DBcon.DBcon;
import dto.Reply;
public class ReplyDao {
	Connection conn = DBcon.getConnection();
    public int insertReply(Reply replyDTO){
        String query = "INSERT INTO replytable(rcontents, bno, uid, r_create_date) VALUES(?, ?, ?, NOW());";
        int result = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1,replyDTO.getRcontents());
            pstmt.setInt(2, replyDTO.getBno());
            pstmt.setString(3, replyDTO.getUid());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    //게시글 번호로 댓글 조회
    public int selectReplyCnt(int bno) {
    	int cnt = 0;
    	String query="SELECT COUNT(*) cnt FROM replytable WHERE bno=?";
    	 try {
             PreparedStatement pstmt = conn.prepareStatement(query);
             pstmt.setInt(1,bno);
             ResultSet rs = pstmt.executeQuery();
             rs.next();
             cnt = rs.getInt(cnt);
             System.out.println(cnt);
         } catch (SQLException e) {
             e.printStackTrace();
         }
    	return cnt;
    }
    public ArrayList<Reply> selectReply(int bno){
        ArrayList<Reply> r = new ArrayList<>();
        Reply replyDto;
        String query = "SELECT rno, uid, rcontents, r_create_date FROM replyTable WHERE bno = ?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1,bno);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
                replyDto = new Reply();
                replyDto.setRcontents(rs.getString("rcontents"));
                replyDto.setUid(rs.getString("uid"));
                replyDto.setRno(rs.getInt("rno"));
                replyDto.setR_create_date(rs.getDate("r_create_date"));
                r.add(replyDto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return r;
    }
    
    public int updateReply(int rno, String uid, String rcontents) {
        String query = "UPDATE replyTable SET rcontents = ?, r_update_date = NOW() WHERE uid = ? and rno = ?;";
        int result = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, rcontents);
            pstmt.setString(2, uid);
            pstmt.setInt(3, rno);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    //댓글 하나 삭제
    public int deleteReply(int rno, String id){
        String query = "DELETE FROM replyTable WHERE uid = ? and rno = ?;";
        int result = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, id);
            pstmt.setInt(2, rno);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    //게시글 삭제 시, 해당 게시글의 댓글 삭제
    public int deleteReplys(int bno) {
    	String query="DELETE FROM replyTable WHERE bno=?;";
    	int result = 0;
    	try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, bno);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    	return result;
    }
}

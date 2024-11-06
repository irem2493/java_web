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
                replyDto.setR_create_date(rs.getTimestamp("r_create_date"));
                r.add(replyDto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return r;
    }
    //댓글을 단 아이디가 맞는지 확인하는 함수
    public int rightMember(int rno, String uid) {
        String query = "SELECT uid FROM replyTable WHERE rno = ?;";
        int result = 0;
        try {
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1,rno);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                if(rs.getString("uid").equals(uid)) result = 1;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
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
}

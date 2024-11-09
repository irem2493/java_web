package dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class Reply {
	private int rno, bno;
    private String rcontents, uid;
    private Date r_create_date;
    private Date r_update_date;
    
    
    public String toJson() {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식 지정

        // 날짜가 null이 아닌 경우 포맷, null일 경우에는 null 반환
        String formattedCreateDate = (r_create_date != null) ? sdf.format(r_create_date) : null;
        String formattedUpdateDate = (r_update_date != null) ? sdf.format(r_update_date) : null;

        // JSON 형태로 문자열 구성
        return "{"
            + "\"rno\": " + rno + ", "
            + "\"bno\": " + bno + ", "
            + "\"rcontents\": \"" + (rcontents != null ? rcontents : "") + "\", "
            + "\"uid\": \"" + (uid != null ? uid : "") + "\", "
            + "\"r_create_date\": \"" + formattedCreateDate + "\", "
            + "\"r_update_date\": \"" + formattedUpdateDate + "\""
            + "}";
	  }
}

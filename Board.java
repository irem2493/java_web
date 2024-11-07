package dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;

@Data
public class Board {
	private int bno;
	private String title, contents, uid;
	private Date create_date;
	
	 public String toJson() {
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식 지정
	        String formattedDate = (create_date != null) ? sdf.format(create_date) : null;  
	        return String.format(
	            "{\"bno\": %d, \"title\": \"%s\", \"contents\": \"%s\", \"uid\": \"%s\", \"createDate\": \"%s\"}",
	            bno, title, contents, uid, formattedDate
	        );
	    }
}

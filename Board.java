package dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class Board {
	int bno;
	String title, contents, uid;
	Date create_date;
	
	 public String toJson() {
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식 지정
	        String formattedDate = (create_date != null) ? sdf.format(create_date) : null;  
	        return String.format(
	            "{\"bno\": %d, \"title\": \"%s\", \"contents\": \"%s\", \"uid\": \"%s\", \"createDate\": \"%s\"}",
	            bno, title, contents, uid, formattedDate
	        );
	    }
}

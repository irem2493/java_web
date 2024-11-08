package dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class User {
	static int uno = 0;
	String uid, upw;
	Timestamp join_date, login_date, logout_date;
	
	
	public User(String uid, String upw) {
		++uno;
		this.uid = uid;
		this.upw = upw;
	}
}

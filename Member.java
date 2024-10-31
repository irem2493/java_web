package dto;



import java.util.Date;

import lombok.Data;

@Data
public class Member {
	private int custno;
	private String custname;
	private String phone;
	private String address;
	private Date joindate;
	private String grade;
	private String city;
	private int sal;
	
	public String toString() {
		return "custno : "+custno+", cusname : "+custname+
				", phone : "+phone+",address : "+address+
				",joindate : "+joindate+", grade : "+grade
				+",city : "+city;
	}
}

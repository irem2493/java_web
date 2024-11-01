package dto;

import lombok.Data;

@Data
public class Order {
	private String orderno;
	private String shopno;
	private String orderdate;
	private String pcode;
	private int amount;
	private int custprice;
	private int disPrice;
	private String shopname;
	private String pname;
	private int pcost;
}

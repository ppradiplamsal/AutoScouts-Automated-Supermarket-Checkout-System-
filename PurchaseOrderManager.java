package autoscouts;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PurchaseOrderManager {
	
	Connection conn = new GetConnection().getConn();
	
	
	public String itemInfo(int barcode, int quantity) {
		String item;
		double price;
		String item_info = null;
		String stmt1 = "select * from items where Barcode='"+barcode+"'";
		String stmt2 = "insert into checkout_list(Barcode, Item, Price, Quantity) values (?,?,?,?)";
		PreparedStatement ps1;
		PreparedStatement ps2;
		ResultSet rs1;
		
		try {
			ps1 = conn.prepareStatement(stmt1);
			rs1 = ps1.executeQuery();
			if(rs1.next()) {
				item = rs1.getString("Item");
				price = rs1.getDouble("Price");
				item_info = Double.toString(price) + "\t" + item;
				ps2 = conn.prepareStatement(stmt2);
				ps2.setInt(1, barcode);
	            ps2.setString(2, item);
	            ps2.setDouble(3, price);
	            ps2.setInt(4, quantity);
	            ps2.executeUpdate();
			}
		
			else {
				item_info = "Sorry item doesn't exist.";
			}
		}
		
		catch (SQLException e) {
		    e.printStackTrace();
		}
		
		return item_info;
	}
	
	
	public int payByCard(int cardno) {
		
		Bank bnk = new Bank();
		return bnk.checkCard(cardno);
		
	}
	
	
	public double payByCash(double grandtotal, double payment_amount) {
		
		return payment_amount-grandtotal;
		
	}
	
	
	
	
	
	
	
}

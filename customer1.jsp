<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Checkout</title>
    </head>
    <body>
    
        <form action="ItemListServ" method="post">
            Barcode: <input type="text" name="barcode" ><br>
            Quantity: <input type="text" name="quantity"><br>
        	<input type="submit" value = "Enter" name = "user_input1"><br>
		</form>
		
		<form action="ItemListServ" method="post">
			<br><br>
			<input type="submit" value = "Subtotal" name = "subtotal"><br>
		</form>
		
		<form action="ItemListServ" method="post">
			<br><br>
			<input type="submit" value = "Total" name = "total"><br>
		</form>
		
		<h1>Your items <br> 
	
	
	<%@ page import = "java.sql.*" %>
	<%@ page import = "java.text.DecimalFormat" %>
	<%@ page import = "autoscouts.GetConnection" %>
	
	<% 
	
	Connection conn = new GetConnection().getConn();
		
	String item;
	double price;
	String item_info = null;
	int barcode = Integer.parseInt(session.getAttribute("barcode").toString());
	int flag = Integer.parseInt(session.getAttribute("flag").toString());
	String stmt1 = "select * from items where Barcode='"+barcode+"'";
	PreparedStatement ps1;
	ResultSet rs1;
	
	//HttpSession session=request.getSession(); 
	
	
	try {
		
		if (flag==0) {
			DecimalFormat df=new DecimalFormat("0.00");
			ps1 = conn.prepareStatement(stmt1);
			rs1 = ps1.executeQuery();
			if(rs1.next()) {
				item = rs1.getString("Item");
				price = Double.parseDouble(df.format(rs1.getDouble("Price")));
				item_info = Double.toString(price) + "\t" + item;
			}
		
			else {
				item_info = "Sorry item doesn't exist.";
			}
			
			out.println(item_info);
		}
		
		else {
			//String item = null;
			int quantity;
       		double sub_tot = 0;
       		String stmt3 = "select * from checkout_list";
       		//String stmt4 = "delete from checkout_list";
       		PreparedStatement ps3;
       		//PreparedStatement ps4;
       		ResultSet rs3;
       		
       		try {
       			//out.println(pom.itemInfo(barcode, quantity));
       			DecimalFormat df=new DecimalFormat("0.00");
       			
       			ps3 = conn.prepareStatement(stmt3);
       			rs3 = ps3.executeQuery();	
       			while(rs3.next()) {
       				barcode = rs3.getInt("Barcode");
       				item = rs3.getString("Item");
       				price = Double.parseDouble(df.format(rs3.getDouble("Price")));
       				quantity = rs3.getInt("Quantity");
       				sub_tot += price*quantity;
       				
       				String item_info1 = Integer.toString(barcode) + "     " + item + "     " + Double.toString(price) + "     " + Integer.toString(quantity);
       				out.println(item_info1);
       				out.println("<br>");
       				
       			}
       			
       			out.println("<br><br>");
       			sub_tot = Double.parseDouble(df.format(sub_tot));        			
       			String st = "Subtotal is:"; out.println(st); out.println(sub_tot);
       			
       			//ps4 = conn.prepareStatement(stmt4);
   				//ps4.executeUpdate();
   				
       			
       			/*if (!rs3.next()) {
       				String[] item_info
       			}*/
       		}
       		
       		catch (SQLException e) {
       			e.printStackTrace();
       		}
       		
			
			
			
			
		}
		
	}
	
	catch (SQLException e) {
	    e.printStackTrace();
	}
	
			
	%>  </h1> 
	
			
		<br><br><br><br>
		
		<form action="ItemListServ" method="post">
			<br><br>
			<input type="submit" value = "Cancel The Entire Transaction" name = "cancel_transaction"><br>
		</form>
		
    </body>
    </html>
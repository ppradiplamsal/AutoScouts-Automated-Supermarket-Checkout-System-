<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Print Total Page</title>
</head>
<body>

<h1> List of Items You Purchased: <br><br>

	<%@ page import = "java.sql.*" %>
	<%@ page import = "java.text.DecimalFormat" %>
	<%@ page import = "autoscouts.GetConnection" %>
	
	<% 
	
	Connection conn = new GetConnection().getConn();
	

			String item = null;
			int barcode, quantity;
       		double price, sub_tot = 0;
       		String stmt3 = "select * from checkout_list";
       		
       		PreparedStatement ps3;
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
       			String st = "Your Total is:"; out.println(st); out.println(sub_tot);
       			
       			session.setAttribute("grandtotal",sub_tot);
       			
   				
       			
       			/*if (!rs3.next()) {
       				String[] item_info
       			}*/
       		}
       		
       		catch (SQLException e) {
       			e.printStackTrace();
       		}
       		
       		
       		%> </h1>
       		
       		
       		
       		<form action="pay_by_card.jsp" method="post">
			<br><br>
			<input type="submit" value = "Pay By Card"><br>
			</form>
		
			<form action="pay_by_cash.jsp" method="post">
			<br><br>
			<input type="submit" value = "Pay By Cash"><br>
			</form>
			
			
					
		<br><br><br><br>
		
		<form action="ItemListServ" method="post">
			<br><br>
			<input type="submit" value = "Cancel The Entire Transaction" name = "cancel_transaction"><br>
		</form>
       		
       		

</body>
</html>
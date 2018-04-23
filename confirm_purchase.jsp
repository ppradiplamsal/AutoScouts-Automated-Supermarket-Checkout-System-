<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%@ page import = "java.sql.*" %>
	<%@ page import = "autoscouts.GetConnection" %>
	<%@ page import = "java.text.DecimalFormat" %>
	
	
	<% 
	
	Connection conn = new GetConnection().getConn();
	
	int flag = Integer.parseInt(session.getAttribute("flag").toString());
	String stmt4 = "insert into day_transactions (Barcode, Item, Price, Quantity)  select Barcode, Item, Price, Quantity from checkout_list";
	String stmt5 = "delete from checkout_list";
	PreparedStatement ps4;
	PreparedStatement ps5;
		
		
	
	if (flag==2) {
		int authno = Integer.parseInt(session.getAttribute("authno").toString());
		if (authno!=0) {
			ps4 = conn.prepareStatement(stmt4);
			ps4.executeUpdate();
			ps5 = conn.prepareStatement(stmt5);
			ps5.executeUpdate();
			
			String st = "Congratulations, you have successfully made the purchase!";
			String st1 = "Your authorization number is: ";
			String st2 = "Your receipt is being printed....";
			out.println(st); out.println("<br>"); out.println(st1); out.println(authno); out.println("<br><br>"); out.println(st2);
			String st3 = "<a href = " + (char)34 + "index1.jsp" + (char)34 + ">" + "Go back to the Welcome Screen</a>";
			out.println(st3);
			
			
		}
		
	   else {
			String st4 = "Sorry, the system could not recognize the card. Please try again.";
			out.println(st4);
			String st5 = "<a href = " + (char)34 + "pay_by_card.jsp" + (char)34 + ">" + "Go to the Pay By Card page</a>";
			out.println(st5);
			

		}
	}
	
	else if (flag==3) {
		DecimalFormat df=new DecimalFormat("0.00");
		double change = Double.parseDouble(session.getAttribute("change").toString());
		change = Double.parseDouble(df.format(change));
		if (change>=0) {
			ps4 = conn.prepareStatement(stmt4);
			ps4.executeUpdate();
			ps5 = conn.prepareStatement(stmt5);
			ps5.executeUpdate();
			
			String st = "Congratulations, you have successfully made the purchase!";
			String st1 = "Your change is: ";
			String st2 = "Your receipt is being printed....";
			out.println(st); out.println("<br>"); out.println(st1); out.println(change); out.println("<br><br>"); out.println(st2);
			String st3 = "<a href = " + (char)34 + "index1.jsp" + (char)34 + ">" + "Go back to the Welcome Screen</a>";
			out.println(st3);
						
		}
		
		else {
			String st4 = "Sorry, the paid amount was not sufficient. Please add ";
			out.println(st4); out.println(change); out.println("more and try again.");
			//implement another button to add more money using out.println
			String st5 = "<a href = " + (char)34 + "pay_by_cash.jsp" + (char)34 + ">" + "Go to the Pay By Cash page</a>";
			out.println(st5);
			
		}
		
		
	}
	
	else {
		
	}
	
	
	%>
	
			
		<br><br>
		
		<form action="ItemListServ" method="post">
			<br><br>
			<input type="submit" value = "Cancel Payment Method" name = "cancel_payment"><br>
		</form>
	
	
				
		<br><br><br><br>
		
		<form action="ItemListServ" method="post">
			<br><br>
			<input type="submit" value = "Cancel The Entire Transaction" name = "cancel_transaction"><br>
		</form>
	

</body>
</html>
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
        	<input type="submit" value = "Enter" name = "user_input"><br>
		</form>
		
		<form action="ItemListServ" method="post">
			<br><br>
			<input type="submit" value = "Subtotal" name = "subtotal"><br>
		</form>
		
		<form action="ItemListServ" method="post">
			<br><br>
			<input type="submit" value = "Total" name = "total"><br>
		</form>
		
		<br><br><br><br>
		
		<form action="ItemListServ" method="post">
			<br><br>
			<input type="submit" value = "Cancel The Entire Transaction" name = "cancel_transaction"><br>
		</form>
		
		
    </body>
    </html>
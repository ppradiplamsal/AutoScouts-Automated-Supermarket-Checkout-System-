<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pay By Card Page</title>
</head>
<body>


<form action="ItemListServ" method="post">
Card Number: <input type="text" name="cardno" ><br>
<input type="submit" value = "Enter" name = "paybycard"><br>
</form>



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
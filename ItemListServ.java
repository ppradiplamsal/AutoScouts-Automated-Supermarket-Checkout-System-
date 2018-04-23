package autoscouts;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.text.DecimalFormat;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



@WebServlet("/ItemListServ")
public class ItemListServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static int barcode, quantity;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PurchaseOrderManager pom = new PurchaseOrderManager();
		Connection conn = new GetConnection().getConn();
		
        HttpSession session=request.getSession();  
        
        String stmt6 = "update items set Quantity = Quantity-1 where Barcode = ?";
        PreparedStatement ps6;
    	
		
		
		try {
            PrintWriter out = response.getWriter();
            
            
            
            if (request.getParameter("user_input")!=null) {
            	barcode = Integer.parseInt(request.getParameter("barcode"));
                quantity = Integer.parseInt(request.getParameter("quantity"));
                
                ps6 = conn.prepareStatement(stmt6);
    			ps6.setInt(1, barcode);
    			ps6.executeUpdate();
    			
                
                session.setAttribute("barcode",barcode);
                session.setAttribute("flag",0);
                pom.itemInfo(barcode, quantity);
                
                int timerr = Integer.parseInt(session.getAttribute("timer").toString());
                if (timerr==1) {
                	             
                	new java.util.Timer().schedule(new TimerTask(){
                    @Override
                    public void run() {
                        //System.out.println("Executed...");
                        
                        String filePath = "C:\\Users\\lamsa\\Desktop\\Daily_Transaction.txt";
                        
                        /*String fileName1 = "C:\\Users\\lamsa\\Desktop\\Daily_Transaction1.txt";
                        String fileName2 = "C:\\Users\\lamsa\\Desktop\\Daily_Transaction2.txt";
                        String fileName3 = "C:\\Users\\lamsa\\Desktop\\Daily_Transaction3.txt";
                        String fileName4 = "C:\\Users\\lamsa\\Desktop\\Daily_Transaction4.txt";
                        */
                        
                        
                        
                        
                        
                		// Content to append.
                		String contentToAppend = null;
                		
                		String item = null;
            			int barcode, quantity;
                   		double price, sub_tot = 0;
                   		String stmt3 = "select * from day_transactions";
                   		
                   		PreparedStatement ps3;
                   		ResultSet rs3;
                   		
                   		try {

                   			DecimalFormat df=new DecimalFormat("0.00");
                   			
                   			ps3 = conn.prepareStatement(stmt3);
                   			rs3 = ps3.executeQuery();	
                   			while(rs3.next()) {
                   				barcode = rs3.getInt("Barcode");
                   				item = rs3.getString("Item");
                   				price = Double.parseDouble(df.format(rs3.getDouble("Price")));
                   				quantity = rs3.getInt("Quantity");
                   				sub_tot += price*quantity;
                   				
                   				contentToAppend = Integer.toString(barcode) + "     " + item + "     " + Double.toString(price) + "     " + Integer.toString(quantity) + "\n";
                   				try (Writer fileWriter = new FileWriter(filePath, true)){
                        			fileWriter.write(contentToAppend);
                        			//((BufferedWriter) fileWriter).newLine();
                   				}
                   			}
                   				
                   				sub_tot = Double.parseDouble(df.format(sub_tot));        			
                   				String st = "The Total Transaction Made Today was:"; out.println(st); out.println(sub_tot);
                   				//fileWriter.write(st);
                   				//try {
                   				//fileWriter.write("pp");
                   				//}
                   			
               				
                   			
                   		}
                   		
                   		catch (SQLException | IOException e) {
                   			e.printStackTrace();
                   		}
                   		
                
                  
                        
                    }
                	},1000*25,1000*25);
                
                }
                
                            	
                response.sendRedirect("customer1.jsp");
                
                
            }
            
            
            else if (request.getParameter("user_input1")!=null) {
            	barcode = Integer.parseInt(request.getParameter("barcode"));
                quantity = Integer.parseInt(request.getParameter("quantity"));
                
                ps6 = conn.prepareStatement(stmt6);
    			ps6.setInt(1, barcode);
    			ps6.executeUpdate();
    			
                
                session.setAttribute("barcode",barcode);
                session.setAttribute("flag",0);
                pom.itemInfo(barcode, quantity);
                
                
                response.sendRedirect("customer1.jsp");
                
            }         
            
            
            
           else if (request.getParameter("subtotal")!=null) {
        	   
        	   session.setAttribute("flag",1);
        	   response.sendRedirect("customer1.jsp");
       		
           }
            
          
            
         else if (request.getParameter("total")!=null) {
        	 
        	 response.sendRedirect("total.jsp");
            	
        	 
         }
            
            
            
         else if (request.getParameter("paybycard")!=null) {
        	
        	int cardno = Integer.parseInt(request.getParameter("cardno"));  
        	int authno = pom.payByCard(cardno);
            
        	session.setAttribute("flag",2);
            session.setAttribute("authno",authno);
            
            //ya printreceipt haala
            response.sendRedirect("confirm_purchase.jsp");
            
        	 
         }
            
            
         else if (request.getParameter("paybycash")!=null) {
        	 
        	 double payment_amount = Double.parseDouble(request.getParameter("payment_amount"));
        	 double grandtotal = Double.parseDouble(session.getAttribute("flag").toString());
         	 //double change = pom.payByCash(grandtotal, payment_amount);
        	 double change = 23.86;
        	 
        	 session.setAttribute("flag",3);
        	 session.setAttribute("change",change);
                          
        	 //ya printreceipt haala
        	 response.sendRedirect("confirm_purchase.jsp");
            	
         }
            
            
            
         else if (request.getParameter("cancel_transaction")!=null) {
        	 
        	 String stmt5 = "delete from checkout_list";
        	 PreparedStatement ps5;
        	        	 
        	 ps5 = conn.prepareStatement(stmt5);
 			 ps5.executeUpdate();
 			 
 			 response.sendRedirect("index.html");
 			 
         }
            
            
         else if (request.getParameter("cancel_payment")!=null) {
        	 
        	 response.sendRedirect("total.jsp");
        	 
         }
             
            
            
            
         else {
        	 
        	 
         }
        
        
            	

        
            
        } 
		
		catch (Exception e) {
            e.printStackTrace();
        }

    }  
     

}

package autoscouts;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

public class AuthorizationCenter {
	
	Connection conn = new GetConnection().getConn();
	
	public int cardExists(int cardno) {
		
		int authno;
		String user;
		Random rnd = new Random();
		
		try {
			PreparedStatement ps = conn.prepareStatement("select User from credit_cards where CardNo='"+cardno+"'");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				user = rs.getString("User");
				authno = rnd.nextInt(147483647)+1147483647;
				return authno;
			}
			
			else {
				return 0;
			}		
			
		}
		
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return 0;
		
	}

}

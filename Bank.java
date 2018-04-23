package autoscouts;

public class Bank {
	
	AuthorizationCenter auth = new AuthorizationCenter();
	
	
	public int checkCard(int cardno) {
		int authno = auth.cardExists(cardno);
		
		if (authno!=0) {
			return authno;
		}
		
		else {
			return 0;
		}
		
	}

}

<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>
<%@ page import="java.text.ParseException" %> 
<%@ page import="java.io.*" %>
<%@ page import="java.util.Scanner" %>

<%

	String user_id = request.getParameter("user_id"); //suck in html ; store in java var
	String tweet_text = request.getParameter("text"); //suck in html ; store in java var
	int hash_id = 0;
	int tweet_id = 0; 
	
	if(tweet_text.length()>0) { 
		try {
		
			//connect to db  -- modify this to fit my database
			java.sql.Connection conn = null;
       		Class.forName("com.mysql.jdbc.Driver").newInstance();
        	String url = "jdbc:mysql://127.0.0.1/smeeks";   //location and name of database
        	String user = "smeeks";
        	String password = "dalton123";
        	conn = DriverManager.getConnection(url, user, password);      //connect to database


			java.sql.PreparedStatement ps = conn.prepareStatement("insert into tweet_t (user_id,tweet) values (?,?)");
			int status = 0; 
			ps.setString (1,user_id);
			ps.setString (2,tweet_text);
        	status = ps.executeUpdate(); 
        		
        	String[] split = tweet_text.split(" "); //split it into words 
        		
        		for(int i = 0; i < split.length; i ++){
                	if(split[i].substring(0, 1).equals("#")){
	               	  String tag = split[i].substring(1); 
                	  String hashtag_q = "SELECT hashtag_id FROM hashtag_t where hashtag = \"" + tag +"\";";
                	  java.sql.Statement hashtag_s = conn.createStatement();
			 		  java.sql.ResultSet hashtag_rs = hashtag_s.executeQuery(hashtag_q);

        
			 		  if(!hashtag_rs.next()){
			 		  	java.sql.PreparedStatement hash_insert = conn.prepareStatement("INSERT INTO hashtag_t (hashtag) VALUES (?)"); //put it into the hash table 
			 		  	hash_insert.setString(1, tag);
			 		  	status = hash_insert.executeUpdate();
			 		  }  
			 		  
			 		  //get the hash id
			 		  String hash_id_q = "SELECT hashtag_id FROM hashtag_t where hashtag = \"" + tag +"\";"; //get the hash ID
                	  java.sql.Statement hash_id_s = conn.createStatement();
			 		  java.sql.ResultSet hash_id_set = hash_id_s.executeQuery(hash_id_q);
			 		  while(hash_id_set.next()){
			 		  	hash_id = Integer.parseInt(hash_id_set.getString(1)); 
			 		  }
        
			 		  //gets the newest tweet ID (the one that was just inserted )
			 		  String tweet_id_q = "SELECT tweet_id from tweet_t GROUP by tweet_id;"; 
			 		  java.sql.Statement tweet_id_s = conn.createStatement();
			 		  java.sql.ResultSet tweet_id_rs = tweet_id_s.executeQuery(tweet_id_q);
			 		  while(tweet_id_rs.next()){
			 		  	 tweet_id = Integer.parseInt(tweet_id_rs.getString(1)); //get tweet ID
			 		  }
			 		  
			 		  java.sql.PreparedStatement h_tweet_rel = conn.prepareStatement("INSERT INTO hashtag_tweet_rel (hashtag_t_id, tweet_t_id) VALUES (?, ?);"); //put it into the hash tweet table
			 		  h_tweet_rel.setString(1, (hash_id+"")); 
			 		  h_tweet_rel.setString(2, (tweet_id+"")); 	
			 		  status = h_tweet_rel.executeUpdate();
                	}
                 		
        		
        	}
    	} catch(Exception e) {
			out.println(e);
		}
    }


%>

<script language="javascript">
    window.location.href = document.referrer; //reloads the page 
</script>

<h1> </h1>

</body>
</html> 


<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

<%
	String fullname = request.getParameter("fullname");
	//out.println(fullname);
	
	String username = request.getParameter("username"); //suck in html ; store in java var 
	//out.println(username);
	
	String email = request.getParameter("email"); //suck in html ; store in java var
	//out.println(email);
		
	String password = request.getParameter("password"); //suck in html ; store in java var
	//out.println(password);
		
	int status = 0;  //capture status after insertion attempt
	int status1 = 0;

	//out.println("username is: " + username);

	try {
	
	//split into first and last name
		//String first_name = fullname.split(" ")[0];
		//String last_name = fullname.split(" ")[1];
	
	//connect to my db 
		java.sql.Connection conn = null;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = "jdbc:mysql://127.0.0.1/smeeks";   //location and name of database
        String user = "smeeks";  
        String pwd = "dalton123";
        conn = DriverManager.getConnection(url, user, pwd);      //connect to database
		java.sql.Statement stmt = conn.createStatement();

	//insert into user_t with values
	java.sql.PreparedStatement ps = conn.prepareStatement("INSERT INTO user_t (username,email,password,fullname) VALUES (?,?,?,?)");
	java.sql.PreparedStatement ps1 = conn.prepareStatement("INSERT INTO follow_rel (user_t_user_id_followee, user_t_user_id_follower) VALUES (?,?)");

	//testing whether username or email already exists or not
	String user_id = "SELECT user_id FROM user_t WHERE username = " + "'" + username + "'" + " OR email= " + "'" + email + "'";
	
	//out.println(user_id);
	java.sql.ResultSet rs = stmt.executeQuery(user_id);
	
	

	
	int u_id = 0; 
	if(!rs.next()) //make new user
	{
		ps.setString (1,username);
		ps.setString (2,email);
		ps.setString (3,password);
		ps.setString (4,fullname);
    	status = ps.executeUpdate(); //insert
    		  
		java.sql.ResultSet rs1 = stmt.executeQuery(user_id);
		if(rs1.next())
		{
			u_id = Integer.parseInt(rs1.getString(1));
			user_id = rs1.getString(1);
			ps1.setString (1,user_id);
    	    ps1.setString (2,user_id);
    	    status1 = ps1.executeUpdate();
	
			//add session variable	
			session.setAttribute( "u_id", (u_id+""));
		
			response.sendRedirect("twitter-home.jsp?key=" + u_id);
		}
	}
	
	else 
	{
	
		response.sendRedirect("Login.jsp?msg=fail");
	
	}




		} catch(Exception e) {
			out.println(e);
		}
%>






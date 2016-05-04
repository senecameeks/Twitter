<%@page language="java" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="com.mysql.jdbc.*" %>

<%
     
      try {

         java.sql.Connection con = null;
         String url = "";

	 String username = request.getParameter("username");
	 String password = request.getParameter("password");
	 int u_id = 0;
	 int status = 0;  //capture status after insertion attempt

	//query 
	 String query = "select user_id, username, fullname, email from user_t WHERE username = " + "'" + username + "'" + "AND password=" + "'" + password + "'"; 
		
	 //open sql:
         Class.forName("com.mysql.jdbc.Driver").newInstance();
         url = "jdbc:mysql://localhost:3306/smeeks";
         con = DriverManager.getConnection(url, "smeeks", "dalton123");
         java.sql.Statement stmt = con.createStatement();
         
	 //executes the query:
	 	java.sql.ResultSet rs = stmt.executeQuery(query);	 

	
	if(rs.next())
	{
		//success
			u_id = Integer.parseInt(rs.getString(1));
		
		//put all your info in session variables
			session.setAttribute( "u_id", (u_id+"") );
			session.setAttribute( "username", rs.getString(2)); 
			session.setAttribute( "fullname", rs.getString(3)); 
			session.setAttribute( "email", rs.getString(4)); 
		
		//redirect to twitter-home		
		response.sendRedirect("twitter-home.jsp?key=" + u_id);
	}
	  
 //fail
	else
	{
		response.sendRedirect("Login.jsp?msg=fail");
		//fail and go back to login page	
	}


      } catch (Exception e) {
         out.println(e);
      }
%>



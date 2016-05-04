<%@ page language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.mysql.jdbc.*" %>

<%

	String p1 = request.getParameter("parameter_1"); //suck in html ; store in java var
	String p2 = request.getParameter("parameter_2"); //suck in html ; store in java var
	int status = 0;  //capture status after insertion attempt

	out.println("p1 is: " + p1);

	//connect to db  -- modify this to fit my database
	java.sql.Connection conn = null;
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = "jdbc:mysql://127.0.0.1/gordie";   //location and name of database
        String userid = "gordie";
        String password = "happy95";
        conn = DriverManager.getConnection(url, userid, password);      //connect to database

	java.sql.PreparedStatement ps = conn.prepareStatement("insert into gordie.test_t (col1,col2) values (?,?)");

	ps.setString (1,p1);
	ps.setString (2,p2);
        status = ps.executeUpdate(); 

/* instead of "key=4" i have to use a SELECT statment, also test for used passwords/failed logins, etc... 
	//success
	if(status > 0)
		response.sendRedirect("twitter_home.jsp?key=4");
	//fail
	else
		response.sendRedirect("login.jsp?msg=fail");
		//fail and go back to login page	
*/
%>

<input type="hidden" name="key" value="99">
<h1> its a beautiful day in the neighborhood! </h1>




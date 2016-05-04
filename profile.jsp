<%@page language="java" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="com.mysql.jdbc.*" %>


<%

    try {

    	java.sql.Connection con = null;
        String url = "";
		String u_id = request.getParameter("u_id");
		String h_id = request.getParameter("hash_id");
		ArrayList<Integer> people_following = new ArrayList<Integer>();
	
	 
	 //Things being displayed
	 String username = "";
	 String first_name = "";
	 String last_name = "";
	 String fullname = "";  
	 int tweets_count = 0;
	 int followers_count = 0;
	 int following_count = 0;
	 String tweets = "";
	 String output = ""; 
	 String hash = "";
	 String tag = "";  

	 //query 
     String user1 = "SELECT username FROM user_t WHERE user_id=" + "'"+ u_id + "'";
     String fullname_q = "SELECT fullname FROM user_t WHERE user_id=" + "'"+ u_id + "'";
     String total_tweets = "SELECT COUNT(*) FROM tweet_t WHERE user_id=" + "'"+ u_id + "'";
     String total_followers = "SELECT COUNT(user_t_user_id_follower) FROM follow_rel where user_t_user_id_followee=" + "'" + u_id + "'"; 
     String total_followees = "SELECT COUNT(user_t_user_id_followee) FROM follow_rel where user_t_user_id_follower=" + "'" + u_id + "'";	
     String my_tweets = "SELECT tweet FROM tweet_t WHERE user_id=" + "'"+ u_id + "'" ; 
     String session_tweets = "SELECT tweet_t.tweet, user_t.username, user_t.fullname from tweet_t inner join follow_rel on follow_rel.user_t_user_id_followee=tweet_t.user_id inner join user_t on user_t.user_id=tweet_t.user_id WHERE follow_rel.user_t_user_id_follower=" + "'"+ u_id + "'" + "OR user_t.user_id=" + "'"+ u_id + "'";
     String hash_tweet_q = "SELECT tweet_t.tweet, user_t.username, user_t.fullname from tweet_t inner join hashtag_tweet_rel on hashtag_tweet_rel.tweet_t_id=tweet_t.tweet_id inner join user_t on user_t.user_id=tweet_t.user_id WHERE hashtag_tweet_rel.hashtag_t_id=" + "'" + h_id + "'";
	 String followers_q = "SELECT user_t.username, user_t.fullname from user_t inner join follow_rel on follow_rel.user_t_user_id_follower=user_t.user_id WHERE user_t_user_id_followee=" + "'"+ u_id + "'";
	  		
		
	 //open sql:
         Class.forName("com.mysql.jdbc.Driver").newInstance();
         url = "jdbc:mysql://localhost:3306/smeeks";
         con = DriverManager.getConnection(url, "smeeks", "dalton123");
         
         
         java.sql.Statement stmt = con.createStatement();
         java.sql.Statement stmt1 = con.createStatement();
         java.sql.Statement stmt2 = con.createStatement();
         java.sql.Statement stmt3 = con.createStatement();
         java.sql.Statement stmt6 = con.createStatement();
         java.sql.Statement stmt7 = con.createStatement();
         
         
	
	 //executes the query:
	 java.sql.ResultSet rs_tweets_count = stmt.executeQuery(total_tweets);	
	 java.sql.ResultSet rs_followers = stmt1.executeQuery(total_followers); 
	 java.sql.ResultSet rs_following = stmt2.executeQuery(total_followees);
	 java.sql.ResultSet rs_username = stmt3.executeQuery(user1);
	 java.sql.ResultSet rs_fullname = stmt6.executeQuery(fullname_q);
	 
	 	

	if(rs_tweets_count.next())
	{
		//success
		 tweets_count= Integer.parseInt(rs_tweets_count.getString(1));
	}
	
	if(rs_followers.next())
	{
		//success
		 followers_count= Integer.parseInt(rs_followers.getString(1));
	}
	
	if(rs_following.next())
	{
		//success
		 following_count= Integer.parseInt(rs_following.getString(1));
	}
	
	if(rs_username.next())
	{
		username= rs_username.getString(1);
	}
	
	if(rs_fullname.next())
	{
		fullname= rs_fullname.getString(1);
		first_name = fullname.split(" ")[0];
		last_name = fullname.split(" ")[1];
	}
	

%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <meta name="description" content="">
    <meta name="author" content="">
    <style type="text/css">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }
    </style>    
    <link rel="stylesheet" href="css/gordy_bootstrap.min.css">
</head>
<body class="user-style-theme1">
    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <i class="nav-home"></i> <a href="#" class="brand">!Twitter</a>
                <div class="nav-collapse collapse">
                    <p class="navbar-text pull-right">Logged in as <a href="#" class="navbar-link"><%=fullname%></a>
                    </p>
                    <ul class="nav">
                        <li class="active"><a href="index.html">Home</a></li>
                        <li><a href="queries.html">Test Queries</a></li>
                        <li><a href="twitter-signin.html">Main sign-in</a></li>
                    </ul>
                </div><!--/ .nav-collapse -->
            </div>
        </div>
    </div>

    <div class="container wrap">
        <div class="row">

            <!-- left column -->
            <div class="span4" id="secondary">
                <div class="module mini-profile">
                    <div class="content">
                        <div class="account-group">
                            <a href="#">
                                <img class="avatar size32" src="images/pirate_normal.jpg" alt="Gordy">
                                <b class="fullname">Gordy</b>
                                <small class="metadata">View my profile page</small>
                            </a>
                        </div>
                    </div>
                    <div class="js-mini-profile-stats-container">
                        <ul class="stats">
                            <li><a href="#"><strong>739</strong>Tweets</a></li>
                            <li><a href="#"><strong>115</strong>Following</a></li>
                            <li><a href="#"><strong>97</strong>Followers</a></li>
                        </ul>
                    </div>
                    <form>
                        <textarea class="tweet-box" placeholder="Compose new Tweet..." id="tweet-box-mini-home-profile"></textarea>
                    </form>
                </div>

                <div class="module other-side-content">
                    <div class="content"
                        <p>Some other content here</p>
                    </div>
                </div>
            </div>

            <!-- right column -->
            <div class="span8 content-main">
                <div class="module">
                    <div class="content">
                        <div class="profile-header-inner" data-background-image="url('images/grey-header-web.png')">
                            <a href="#" class="profile-picture media-thumbnail">
                                <img src="images/profileThumb.jpeg" alt="Barack Obama" class="avatar size73">
                            </a>
                            <div class="profile-card-inner">
                                <h1 class="fullname">Barack Obama</h1>
                                <h2 class="username">@barakobama</h2>
                                <div class="bio-container">
                                    <p class="bio profile-field">This account is run by Organizing for Action staff. Tweets from the President are signed -bo.
Washington, DC · http://www.barackobama.com</p>
                                </div>
                            </div>
                        </div>
                        <div class="flex-module profile-banner-footer clearfix">
                            <div class="default-footer">
                                <ul class="stats js-mini-profile-stats" style="float:left">
                                    <li>
                                        <a class="js-nav" href="#">
                                            <strong>8,716</strong>
                                            Tweets
                                        </a>
                                    </li>
                                    <li>
                                        <a class="js-nav" href="#">
                                            <strong>665,052</strong>
                                            Following
                                        </a>
                                    </li>
                                    <li>
                                        <a class="js-nav" href="#">
                                            <strong>27,899,207</strong>
                                            Followers
                                        </a>
                                    </li>
                                </ul>
                                <a href="#dm" class="btn dm-button pull-right" type="button" title"Direct Messages" data-toggle="modal">
                                    <i class="icon-envelope"></i>
                                </a>
                                <div id="dm" class="modal hide fade">
                                    <div class="modal-header twttr-dialog-header">
                                        <div class="twttr-dialog-close" data-dismiss="modal" aria-hidden="true">&nbsp;</div>
                                        <h3>Direct Messages</h3>
                                    </div>
                                    <div class="modal-body">
                                        <!-- direct messages start -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->
                                        <!-- start tweet -->
                                        <div class="js-stream-item stream-item expanding-string-item">
                                            <div class="tweet original-tweet">
                                                <div class="content">
                                                    <div class="stream-item-header">
                                                        <small class="time">
                                                            <a href="#" class="tweet-timestamp" title="10:15am - 16 Nov 12">
                                                                <span class="_timestamp">6m</span>
                                                            </a>
                                                        </small>
                                                        <a class="account-group">
                                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                                            <strong class="fullname">Barak Obama</strong>
                                                            <span>&rlm;</span>
                                                            <span class="username">
                                                                <s>@</s>
                                                                <b>barakobama</b>
                                                            </span>
                                                        </a>
                                                    </div>
                                                    <p class="js-tweet-text">
                                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                                            <span class="invisible">http://</span>
                                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                                            <span class="invisible"></span>
                                                            <span class="tco-ellipsis">
                                                                <span class="invisible">&nbsp;</span>
                                                            </span>
                                                        </a>
                                                    </p>
                                                </div>
                                            </a>
                                                <div class="expanded-content js-tweet-details-dropdown"></div>
                                            </div>
                                        </div>
                                        <!-- end tweet -->

                                        <!-- direct messages end -->
                                    </div>
                                    <div class="twttr-dialog-footer">
                                        Tip: you can send a message to anyone who follows you. <a href="#" target="_blank" class="learn-more">Learn more</a>
                                  </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="module">
                    <div class="content-header">
                        <div class="header-inner">
                            <h2 class="js-timeline-title">Tweets</h2>
                        </div>
                    </div>

                    <!-- new tweets alert -->
                    <div class="stream-item hidden">
                        <div class="new-tweets-bar js-new-tweets-bar well">
                            2 new Tweets
                        </div>
                    </div>

                    <!-- all tweets -->
                    <div class="stream following-stream">

<% 
	java.sql.Statement stmt4 = con.createStatement();
	java.sql.ResultSet rs_tweets = stmt4.executeQuery(session_tweets);
	
	//java.sql.ResultSet rs_followee_tweets = stmt5.executeQuery(tweets_user_follows);
	while(rs_tweets.next())
	{ //open
		tweets= rs_tweets.getString("tweet");
		username = rs_tweets.getString("username");
		fullname = rs_tweets.getString("fullname");
		

	
%>
    
                        <!-- start tweet -->
                        <div class="js-stream-item stream-item expanding-string-item">
                            <div class="tweet original-tweet">
                                <div class="user-actions">
                                    <a class="btn">btn</a>
                                    <a class="btn follow-btn">
                                        <span class-="button-text follow-text">
                                            <i class="follow"></i>
                                            Follow
                                        </span>
                                    </a>
                                </div>
                                <div class="content">
                                    <div class="stream-item-header">
                                        <a class="account-group">
                                            <img class="avatar" src="images/obama.png" alt="Barak Obama">
                                            <strong class="fullname">Barak Obama</strong>
                                            <span>&rlm;</span>
                                            <span class="username">
                                                <s>@</s>
                                                <b>barakobama</b>
                                            </span>
                                        </a>
                                    </div>
                                    <p class="js-tweet-text">
                                        "I've got a mandate to help middle-class families." -President Obama at his news conference yesterday: "
                                        <a href="http://t.co/xOqdhPgH" class="twitter-timeline-link" target="_blank" title="http://OFA.BO/xRSG9n" dir="ltr">
                                            <span class="invisible">http://</span>
                                            <span class="js-display-url">OFA.BO/xRSG9n</span>
                                            <span class="invisible"></span>
                                            <span class="tco-ellipsis">
                                                <span class="invisible">&nbsp;</span>
                                            </span>
                                        </a>
                                    </p>
                                </div>

                                <div class="expanded-content js-tweet-details-dropdown"></div>
                            </div>
                        </div><!-- end tweet -->
<% 

}//while

%>
                    </div>
                    <div class="stream-footer"></div>
                    <div class="hidden-replies-container"></div>
                    <div class="stream-autoplay-marker"></div>
                </div>
                </div>
               
            </div>
        </div>
    </div>
     <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <script type="text/javascript" src="js/main-ck.js"></script>
  </body>
</html>
  <%
 } 
	} //try	
	catch(Exception e){
    	out.println(e); 
 		 }
  
</html>
use smeeks;

/* GET THE TWEETS FOR ALL THE PEOPLE YOU ARE FOLLOWING A GIVING USER. */
SELECT tweet_t.tweet, user_t.username from tweet_t inner join follow_rel on follow_rel.user_t_user_id_followee=tweet_t.user_id inner join user_t on user_t.user_id=tweet_t.user_id WHERE follow_rel.user_t_user_id_follower="1";

/* ADD HASHTAG TABLE */
CREATE TABLE `hashtag_t` (
  `hashtag_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tweet_t_tweet_id` int(11) unsigned NOT NULL,
  `tweet_t_users_t_user_id` int(11) unsigned NOT NULL,
  `hashtag` varchar(48) NOT NULL DEFAULT '',
  PRIMARY KEY (`hashtag_id`),
  KEY `tweet_t` (`tweet_t_tweet_id`),
  CONSTRAINT `tweet_t` FOREIGN KEY (`tweet_t_tweet_id`) REFERENCES `tweet_t` (`tweet_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/* ADD HASHTAG_TWEET RELATIONSHIP TABEL */
CREATE TABLE `hashtag_tweet_rel` (
  `hashtag_t_id` int(11) unsigned NOT NULL,
  `tweet_t_id` int(11) unsigned NOT NULL,
  KEY `hashtag_t_id` (`hashtag_t_id`),
  KEY `tweet_t_id` (`tweet_t_id`),
  CONSTRAINT `hashtag_t_id` FOREIGN KEY (`hashtag_t_id`) REFERENCES `hashtag_t` (`hashtag_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tweet_t_id` FOREIGN KEY (`tweet_t_id`) REFERENCES `tweet_t` (`tweet_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/* INSERT HASHTAG */ 
INSERT INTO hashtag_t VALUES(4, "#Test");

/* INSERT A NEW USER INTO YOUR USER TABLE WITH META DATA */
INSERT INTO user_t VALUES(7, "test", "test1@case.com", "dalton123"); 

/* SELECT TOTAL AMOUNT OF TWEETS for username with username=“Seneca” */
SELECT COUNT(*) AS "Total Tweets of User" FROM tweet_t WHERE user_id="1"; 

/* SELECT TOTAL AMOUNT OF FOLLOWERS FROM 'FOLLOW_REL’ TABLE FOR A GIVEN USER */
SELECT COUNT(user_t_user_id_follower) AS "Total Followers" FROM follow_rel where user_t_user_id_followee="1";  

/* SELECT TOTAL AMOUNT OF FOLLOWEES FROM 'FOLLOW_REL’ TABLE */
SELECT COUNT(user_t_user_id_followee) AS "Total Followees" FROM follow_rel where user_t_user_id_follower="1";

/* RETRIEVE PRIMARY using username/password or email/password */
SELECT user_id FROM user_t where username="Seneca" AND password="dalton123" OR email="seneca@dalton.org" AND password="dalton123";

/* RETRIEVE ALL HASHTAG ID'S FROM FOR A GIVEN TWEET */
SELECT hashtag_t_id FROM hashtag_tweet_rel WHERE tweet_t_id="1";






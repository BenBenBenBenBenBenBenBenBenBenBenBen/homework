<?php
require_once 'siteFunctions/commonFunctions.php';
require_once 'siteFunctions/masterPage.php';
require_once 'framework/MySQLDB.php';

	try {
		$db=getNewDatabase();
		$db->execute( "drop table if exists members");
	   
		$db->execute( "create table members
						(memberID  		integer not null,
						 login			char(30),
						 givenName 		char(30),
						 familyName 	char(30),
						 passwordHash	char(64),
						 emailAddress	char(100),
						 isAdmin		boolean,
						 primary key	(memberID), 
						 unique key 	(login)
						)");
	   
		$db->execute( "insert into members values ( 101,'rubblef','Fred', 'Rubble','','',false )") ;
		$db->execute( "insert into members values ( 102,'flintstoneb','Barney','Flintstone','','',false)" )  ;
		$db->execute( "insert into members values ( 103,'astles','Stephen', 'Astle','f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','',false)" ) ;
		$db->execute( "insert into members values ( 104,'flemingn','Nathan', 'Fleming','','',false)" ) ;
		$db->execute( "insert into members values ( 105,'englishh','Helen', 'English','','',false)" ) ;
		$db->execute( "insert into members values ( 106,'clarkb','Bill', 'Clark','','',false)" ) ;
		$db->execute( "insert into members values ( 107,'lancem','Mike', 'Lance','289e8d2f0b4cb6278618282a3fa7555bd1abef03e213f81b8598ced551218a02','',true)" ) ;
		$db->execute( "insert into members values ( 108,'lopezm','Mike', 'Lopez','dcc70369941f7a6d70b01334a1c522b4c4426e5328a2b45586d59e16c9934dc5','',true)" ) ;
		$db->execute( "insert into members values ( 109,'sarkara','Amit', 'Sarkar','','',true)" ) ;
		
		
		$db->execute( "drop table if exists rooms");
		$db->execute( "create table rooms
						(roomID  		integer not null,
						 roomNumber		varchar(100),
						 capacity		integer,
						 description	varchar(1000),
						 primary key	(roomID)
						)");
						 
		$db->execute( "insert into rooms values ( 201, 'X203', 24, '' )" );
		$db->execute( "insert into rooms values ( 202, 'X205', 38, '' )" );
		$db->execute( "insert into rooms values ( 208, 'X208', 20, '' )" );
		
		$db->execute( "drop table if exists bookings");
		$db->execute( "create table bookings
						(bookingID	integer not null auto_increment,
						 roomID 		integer not null,
						 memberID		integer not null,
						 dateTaken		date,
						 dateReturned	date,
						 primary key	(bookingID),
						 foreign key 	(roomID) references rooms(roomID),
						 foreign key 	(memberID) references members (memberID)
						)");
							 
		$db->execute( "insert into bookings(roomID, memberID, dateTaken) values(201,108,'2014-05-02')") ;
			
		$content='<p>The database has been built.</p>';
		
		$pg=new MasterPage();
		$pg->setTitle('Database build/rebuild');
		$pg->setContent($content);
		print $pg->getHtml();
		
	} catch (exception $ex) {
		print $ex;
	}


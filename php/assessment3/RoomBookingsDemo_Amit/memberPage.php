<?php

require_once 'framework/htmlTemplate.php';
require_once 'framework/htmlTable.php';
require_once 'models/member.php';
require_once 'siteFunctions/commonFunctions.php';
require_once 'siteFunctions/masterPage.php';
		
	try {
		$pg = new MasterPage();	
		$member = $pg->getMember();	
		$memberID=$member->getID();
		$db=$pg->getDB();		
		$bookings = $db->query("select roomNumber, description, dateTaken ".
					   "from bookings b inner join rooms r ".
					   "on b.roomID = r.roomID ".
					   "where b.memberID=$memberID".
					   " and dateReturned is null");
							   
		$content="<p>Welcome to the member page</p>";
		
		if ($bookings->size()> 0) {
			$content.='<h3>Your current bookings are shown below:</h3><br/>';
			$table=new HtmlTable ($bookings);
			$content.=$table->getHtml( array (
				'bookingID'=>'BookingID', 
				'memberID'=>'Membership ID',
				'<<dateTaken|date>>'=>'Booked on'));
		} else {
			$content.='<p>You have no current bookings</p>';
		}
		
		$content.='<br/><p><a href="book.php">Book a room</a></p>';
		
		$pg->setTitle('Member Page');
		$pg->setContent($content);
		print $pg->getHtml();
		
	} catch (exception $ex) {
		
		//header ("location: login.php");
	}

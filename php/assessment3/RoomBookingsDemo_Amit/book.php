<?php

require_once 'framework/htmlTemplate.php';
require_once 'framework/htmlTable.php';
require_once 'models/member.php';
require_once 'siteFunctions/commonFunctions.php';
require_once 'siteFunctions/masterPage.php';
		
	try {
		$pg = new MasterPage();	
		$db=$pg->getDB();			
		$member = $pg->getMember();	
		if ($member==null) {
			header('location: login.php');
			exit();
		}
		$today = date("Y-m-d");
		$memberID=$member->getID();
		$bookID = getFromUrl('id');
		$content="";
		
		if ($bookID==null) {				
			$sql="select roomID, roomNumber, capacity, description from rooms ". 
				 "where roomID not in ".
				 "(select roomID from bookings where dateReturned is null)";
				
			$availableRooms = $db->query($sql);
			
			if ($availableRooms->size()> 0) {
				$content.='<h3>Available Rooms</h3>';
				$table=new HtmlTable ($availableRooms);
				$content.=$table->getHtml( array (
					'roomNumber'=>'Room Number',
						'capacity'=>'Room Capacity',
					'description'=>'Room Description',
					'<a href="Book.php?id=<<roomID>>" >Book</a>'=>'Action'));
				$content.='<p>&nbsp;</p>';
			} else {
				$content.='<p>There are no rooms available</p>'.$sql;
			}
		} else {
			$sql="insert into bookings values(null,$roomID,$memberID,'$today',null)";
			//print $sql;
			$db->execute($sql);	    
			$content='<p>Booking of the room has been recorded<p>';
			$content.='<p><a href="book.php">Boook another room</a></p>';
			$content.='<p><a href="memberPage.php">Review bookings</a></p>';
		}	
		
		$pg->setTitle('Room booking');
		$pg->setContent($content);
		print $pg->getHtml();
		
	} catch (exception $ex) {	
		//header ("location: login.php");
	}

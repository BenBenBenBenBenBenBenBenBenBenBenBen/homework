<?php
require_once 'siteFunctions/masterPage.php';

	$pg=new MasterPage();
	if ($pg->getMember()!=null) {
		header("location: memberPage.php");
	} else {
			
		if ($bookings->size()> 0) {
			$content.='<h3>Your current bookings are shown below:</h3><br/>';
			$table=new HtmlTable ($product);
			$content.=$table->getHtml( array (
				'bookingID'=>'BookingID', 
				'memberID'=>'Membership ID',
				'<<dateTaken|date>>'=>'Booked on'));
		} else {
			$content.='<p>You have no current bookings</p>';
		}

				   
		$pg->setTitle('Welcome to FreshCart');
		$pg->setContent($content);
		print $pg->getHtml();
	}
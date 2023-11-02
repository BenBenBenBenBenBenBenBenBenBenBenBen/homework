<?php
	include_once 'siteFunctions/commonFunctions.php';
	include_once 'siteFunctions/masterPage.php';
	require_once 'framework/htmlTemplate.php';
	require_once 'framework/htmlTable.php';

	$page = new MasterPage();
	
	$content="";

	// get any specified search terms from the URL or the form
	$keywords= getFromUrl('search');

	// show the results if we have any search terms
	/*if (isSpecified($keywords) ){
		$db = $page->getDB();
		$sql="select bookID, authors, bookName, description, datePublished, isbn ".
			 "from books where bookName like '%$keywords%' or ".
			 "description like '%$keywords%' or ".
			 "authors like '%$keywords%' ".
			 "order by authors, datePublished, bookName";
	*/
	if (isSpecified($keywords) ){
		$db = $page->getDB();
		$sql="select bookingID, roomID, memberID, dateTaken, dateReturned ".
			 "from bookings where bookingID like '%$keywords%' or ".
			 "roomID like '%$keywords%' or ".
			 "memberID like '%$keywords%' ".
			 "order by bookingID, roomID, memberID";
		//print $sql;
		$bookings = $db->query($sql);
		if ($bookings!=false) {
			if ($bookings->size()==0) {
				$content="<p>No bookings found for $keywords</p>";
			} else {
				// Format the bookings as an HTML table
				$table=new HtmlTable ($bookings);
				
				
				/* $content= $table->getHtml( array (
					'<<datePublished|date>>'=>'Date',
					'bookName'=>'Name',
					'description'=>'Description',
					'authors'=>'Author(s)')); */
				$content= $table->getHtml( array (
					'bookingID'=>'Booking ID',
					'memberID'=>'Member ID',
					'roomID'=>'Room Number'));	
			}
		}
	}
	
	// Note - we always show a search form so the user can do another search
	$form = new HtmlTemplate('search.html');

	// show any old values we have in the form
	$oldValues=array('oldSearch'=>getOldValue($keywords));
		
	// add the form to the results
	$content .= $form->getHtml($oldValues);
	
	// Finally, place the content in our master page
	$page->setTitle('Bookings search');
	$page->setContent($content);	
	print $page->getHtml();
		
	// returns true if a search term is not blank
	function isSpecified ($var) {
		if ($var==null || trim($var =='')) {
			return false;
		}
		return true;
	}
	
	// If we have a value return ~ value='xxx' else return blank
	function getOldValue ($val) {
		if ($val==null) {
			return "";
		}
		return ' value="'.$val.'" ';
	}

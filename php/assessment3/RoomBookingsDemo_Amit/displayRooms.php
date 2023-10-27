<?php
	include_once 'siteFunctions/commonFunctions.php';
	include_once 'siteFunctions/masterPage.php';
	require_once 'framework/htmlTemplate.php';
	require_once 'framework/htmlTable.php';

	$page = new MasterPage();
	$db = $page->getDB();
	$sql="select bookID, authors, bookName, description, datePublished, isbn ".
		 "from books ".
		 "order by authors, datePublished, bookName";

	$books = $db->query($sql);
	
	// Format the books as an HTML table
	$table=new HtmlTable ($books);
	$content= $table->getHtml( array (
		'isbn'=>'ISBN',
		'authors'=>'Author(s)',
		'<<datePublished|date>>'=>'Date',
		'bookName'=>'Name',
		'description'=>'Description' 
		));
	
	// Finally, place the content in our master page
	$page->setTitle('Books database');
	$page->setContent($content);	
	print $page->getHtml();
?>

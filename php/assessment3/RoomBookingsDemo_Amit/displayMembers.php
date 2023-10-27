<?php
	include_once 'siteFunctions/commonFunctions.php';
	include_once 'siteFunctions/masterPage.php';
	require_once 'framework/htmlTemplate.php';
	require_once 'framework/htmlTable.php';

	$page = new MasterPage();
	$db = $page->getDB();
	$sql="select * from members";

	$members = $db->query($sql);
	
	// Format the members as an HTML table
	$table=new HtmlTable ($members);
	$content= $table->getHtml( array (
		'memberID'=>'MemberID',
		'givenName'=>'GivenName',
		'familyName'=>'FamilyName' 
		));
	
	// Finally, place the content in our master page
	$page->setTitle('Member database');
	$page->setContent($content);	
	print $page->getHtml();


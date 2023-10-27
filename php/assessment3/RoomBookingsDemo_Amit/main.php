<?php
require_once 'siteFunctions/masterPage.php';

	$pg=new MasterPage();
	if ($pg->getMember()!=null) {
		header("location: memberPage.php");
	} else {
			
		$content='<p>Welcome to the Demo site for <strong>BCDE224</strong>.</p>';
		$content.='<p>Start by running the build option which will create the database and load some sample data.</p>';
		$content.='<p>Login using <strong>astles</strong> and password <strong> aa </strong>:';
		$content.='<p><strong>search.php</strong></p>';
		$content.='<p><strong>memberPage.php</strong></p>';
		$content.='<p><strong>book.php</strong></p>';
		
		$content.='<p>The search script should ask the user to enter a search term. '.
				  'It should then display an HTML table showing the Booking ID,'.
				  ' MemberID, and room number which match the term '.
				  'on Booking ID, MemberID, or room number.</p>';

		$content.='<p>The user does not need to login to carry out a search. However, '.
		          'the member and booking scripts are only available to logged in users.</p>';

				   
		$pg->setTitle('Welcome and Instructions');
		$pg->setContent($content);
		print $pg->getHtml();
	}



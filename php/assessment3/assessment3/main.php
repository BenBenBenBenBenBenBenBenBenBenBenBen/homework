<?php
require_once 'siteFunctions/masterPage.php';

	$pg=new MasterPage();
	if ($pg->getMember()!=null) {
		header("location: memberPage.php");
	} else {
			
		$content='';

				   
		$pg->setTitle('Welcome to FreshCart');
		$pg->setContent($content);
		print $pg->getHtml();
	}
<?php
require_once 'siteFunctions/commonFunctions.php';
require_once 'siteFunctions/masterPage.php';
require_once 'framework/MySQLDB.php';

	try {
		$db=getNewDatabase();
		$db->execute("CREATE TABLE IF NOT EXISTS user_tbl(
			username varchar(20) Primary key NOT NULL,
			password char(64) NOT NULL,
			firstName varchar(20) NOT NULL,
			lastName varchar(20) NOT NULL
		);");

		$db->execute("INSERT INTO `user_tbl` (`username`, `password`, `firstName`, `lastName`)
		VALUES
		  ('Wesley', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3', 'Rhiannon', 'Salazar'),
		  ('Wallace', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','Jacob','Edwards'),
		  ('Genevieve', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','Felix','Crosby'),
		  ('Wylie', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','Bianca','Cameron'),
		  ('Joelle', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','Cooper','Wilkins'),
		  ('Geoffrey', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','Tanek','Santiago'),
		  ('Darryl', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','Whoopi','Rivas'),
		  ('Zane', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','Irene','Roberson'),
		  ('Chastity', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','Quintessa','Martin'),
		  ('Philip', 'f79cd5cea2b075f760c4cce61386066fdeb15e94a8236db62bb1ad33a6b7bbd3','Ivory','Snider');");


		$db->execute( "CREATE TABLE IF NOT EXISTS Product(
			productName varchar(20) NOT NULL,
			productDescription varchar(200) NOT NULL PRIMARY KEY,
			price DECIMAL(10, 2),
			productImageLink varchar(100) NOT NULL,
			seller_username varchar(20) NOT NULL,
			foreign key(seller_username) references user_tbl(username)
		);"); 

		$db->execute("INSERT INTO `Product` (`productName`, `productDescription`, `price`, `productImageLink`, `seller_username`)
			VALUES
			('apple', 'an apple', '1.50', 'img/royal-gala.jpg', 'Wesley'),
			('pear', 'a pear', '1.50', 'img/bartlett.jpg', 'Wallace'),
			('banana', 'a banana', '1.50', 'img/Banana-Single.jpg', 'Genevieve'),
			('orange', 'a orange', '1.50', 'img/orange.jpg', 'Wylie'),
			('dragon fruit', 'a dragon fruit', '1.50', 'img/Pitaya_cross_section_ed2.jpg', 'Joelle'),
			('water melon', 'a water melon', '1.50', 'img/shutterstock_583745164-1.jpg', 'Geoffrey'),
			('durian', 'a durian', '1.50', 'img/discoveringw.jpg', 'Darryl'),
			('rock melon', 'a rock melon', '1.50', 'img/11013-ve-rock-melon-hales-bast_2.jpg', 'Zane'),
			('honeydew melon', 'a honeydew melon', '1.50', 'img/Honeydew.jpg', 'Chastity'),
			('jack fruit', 'a jack fruit', '1.50', 'img/eatJackfruit-823672534-770x533-1-650x428.jpg', 'Philip');");

		$pg=new MasterPage();
		$pg->setTitle('Database build/rebuild');
		$pg->setContent($content);
		print $pg->getHtml();

	} catch (exception $ex) {
		print $ex;
	}
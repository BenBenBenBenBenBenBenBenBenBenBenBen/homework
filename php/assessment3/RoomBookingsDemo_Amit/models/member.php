<?php
	require_once 'models/entity.php';
/*
	Current logged in member is memberID in session
*/

class MemberModel extends EntityModel{

	/* CONSTRUCTOR */
	function __construct($db, $memberID) {
		
		parent::__construct($db,'members');			// Bind to members table
		parent::defineKey ('memberID',$memberID);	// Define primary key
		parent::defineField ('login');			// Say which fields we care about
		parent::defineField ('givenName');
		parent::defineField ('familyName');
		parent::defineField ('passwordHash');
		parent::defineField ('emailAddress');
		parent::defineField ('isAdmin');
		
		if ($memberID!=null) {
			parent::load();
		}
	}
	
	
	/* 	PUBLIC SETTERS */
	public function setLogin($value) {
		parent::setValue('login',"'$value'");
	}
	public function setGivenName($value) {
		parent::setValue('givenName',"'$value'");
	}
	public function setFamilyName($value) {
		parent::setValue('familyName',"'$value");
	}
	public function setPasswordHash($value) {
		parent::setValue('passwordHash',"'$value'");
	}
	public function setEmailAddress($value) {
		parent::setValue('emailAddress',$value);
	}
	public function setIsAdmin($value) {
		parent::setValue('isAdmin',$value);
	}
	
	/* PUBLIC GETTERS */
	function getID() {
		return parent::getID();
	}
	public function getLogin() {
		return parent::getValue('login');
	}
	public function getGivenName() {
		return parent::getValue('givenName');
	}
	public function getFamilyName() {
		return parent::getValue('familyName');
	}
	public function getFullName() {
		return $this->getGivenName() . ' ' . $this->getFamilyName() ;
	}
	public function getPasswordHash() {
		return parent::getValue('passwordHash');
	}
	public function getEmailAddress() {
		return parent::getValue('emailAddress');
	}
	public function getIsAdmin() {
		return parent::getValue('isAdmin');
	}
	
	/* HELPER FUNCTIONS */
	
	public function isValidPassword() {
		$hash = "xxx";  //todo: calculate
		// get hash and compare
		return true;
		
	}	
}
?>

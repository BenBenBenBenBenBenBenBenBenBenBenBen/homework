<?php
	require_once 'framework/htmlTemplate.php';
	require_once 'siteFunctions/commonFunctions.php';
	require_once 'models/member.php';

class MasterPage {

	var $db;
	var $title;
	var $memberID;
	var $member;
	var $content;
	
	public function __construct() {
		$this->title='Untitled';
		$this->memberID=null;
		$this->member=null;
		$this->content="<p>content not yet specified</p>";
		$this->db=getDatabase();
		$this->init();
	}
	
	private function init () {
		session_save_path ('.\sessions');
		session_start();	
		if (isset($_SESSION['memberID'])) {
			$this->memberID=$_SESSION['memberID'];
		}
		if ($this->memberID!=null) {
			$this->member=new MemberModel($this->db, $this->memberID);
		}
	}
		
	public function setTitle($title) {
		$this->title = $title;
	}
	
	public function setContent($content) {
		$this->content=$content;
	}

	public function getDB() {
		return $this->db;
	}
	
	public function getMember() {
		return $this->member;
	}

	public function getHtml() {		
		$pg = new HtmlTemplate('masterPage.html');
		return $pg->getHtml(array(
			'pagename'=>$this->title,
			'login'=>$this->getLoginPanel(),
			'content'=>$this->content));
	}
	
	public function logout() {
		$this->memberID=null;
		$this->member=null;
		session_destroy();
	}
	
	private function getLoginPanel() {
		if ($this->member==null) {
			return '<li><a href="login.php">Login</a></li>';
		}
		$html='<span class="login">Logged in as <em>'.$this->member->getFullName().'</em>';
		if ($this->member->getIsAdmin()==true){
			$html.=' (administrator)';
		}
		$html .= '<li><a href="logout.php">Logout</a></li>';
		$html .='</span>';
		return $html;
	}
}


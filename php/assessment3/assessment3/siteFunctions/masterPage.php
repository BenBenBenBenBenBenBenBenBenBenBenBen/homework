<?php
require_once 'framework/htmlTemplate.php';
require_once 'siteFunctions/commonFunctions.php';
require_once 'models/product.php';

class MasterPage {

    var $db;
    var $title;
    var $productDescription;
    var $product;
    var $content;

    public function __construct() {
        $this->title = 'Untitled';
        $this->productDescription = null;
        $this->product = null;
        $this->content = "<p>content not yet specified</p>";
        $this->db = getDatabase();
        $this->init();
    }

	private function init () {
		session_save_path ('.\sessions');
		session_start();	
		if (isset($_SESSION['productDescription'])) {
			$this->productDescription=$_SESSION['productDescription'];
		}
		if ($this->productDescription!=null) {
			$this->product=new ProductModel($this->db, $this->productDescription);
		}
	}
	

    public function setTitle($title) {
        $this->title = $title;
    }

    public function setContent($content) {
        $this->content = $content;
    }

    public function getDB() {
        return $this->db;
    }

    public function getProduct() {
        return $this->product;
    }

    public function getHtml() {
        $pg = new HtmlTemplate('masterPage.html');
        return $pg->getHtml(array(
            'pagename' => $this->title,
            'login' => $this->getLoginPanel(),
            'content' => $this->content));
    }
}
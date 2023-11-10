<?php
	require_once 'models/entity.php';

	class ProductModel extends EntityModel{

		/* CONSTRUCTOR */
		function __construct($db, $productName, $productDescription) {
			
			parent::__construct($db, 'products');		// Bind to products table
			parent::defineField('productName');	// Define primary key
			parent::defineKey('productDescription', $productDescription);
			parent::defineField('price');
			parent::defineField('productImageLink');
			parent::defineField('seller_username');
			
			if ($productDescription != null) {
				parent::load();
			}
		}
		
		
		/* PUBLIC SETTERS */
		public function setPrice($value) {
			parent::setValue('price', "'$value'");
		}
		public function setProductImageLink($value) {
			parent::setValue('productImageLink', "'$value'");
		}
		public function setSellerUsername($value) {
			parent::setValue('seller_username', "'$value'");
		}
		
		/* PUBLIC GETTERS */
		public function getProductName() {
			return parent::getValue('productName');
		}
		public function getProductDescription() {
			return parent::getValue('productDescription');
		}
		public function getPrice() {
			return parent::getValue('price');
		}
		public function getProductImageLink() {
			return parent::getValue('productImageLink');
		}
		public function getSellerUsername() {
			return parent::getValue('seller_username');
		}
		
		/* HELPER FUNCTIONS */
		
		// Add any additional helper functions as needed
		
	}
?>

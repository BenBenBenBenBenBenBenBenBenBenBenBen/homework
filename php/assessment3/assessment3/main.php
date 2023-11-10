<?php
require_once 'framework/htmlTemplate.php';
require_once 'framework/htmlTable.php';
require_once 'models/product.php';
require_once 'siteFunctions/commonFunctions.php';
require_once 'siteFunctions/masterPage.php';

try {
    $pg = new MasterPage();
    $productModel = $pg->getProduct();
    $productName = $productModel->getProductName();
    $productDescription = $productModel->getProductDescription();
    $db = $pg->getDB();
    $product = $db->query("SELECT productName, productDescription, price, productImageLink FROM freshcart.product;");

    $content = var_dump($product);

    $pg->setTitle('Product Page');
    $pg->setContent($content);
    print $pg->getHtml();
} catch (Exception $ex) {
    // Handle the exception, redirect, or perform other actions
    // header("location: login.php");
}
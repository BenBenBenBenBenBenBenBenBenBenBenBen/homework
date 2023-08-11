<?php

include "controller.php";

$jsonPath="json/elections.json";
$jsonString = file_get_contents($jsonPath);
$ElectionJSON = json_decode($jsonString, true);

$theController=new Controller;

$theElection=$theController->setup($ElectionJSON);

echo $theElection->__toString();

?>
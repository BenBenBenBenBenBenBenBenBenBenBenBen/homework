<?php

include_once('tabletool.inc');


$numbers = array();
$numbers[1] = 11;
$numbers[] = 22;
$numbers[] = 33;
$numbers[] = 44;
$numbers[] = 55;
$numbers[] = 66;
$numbers[] = 77;

echoTable($numbers);

echo '<br>';


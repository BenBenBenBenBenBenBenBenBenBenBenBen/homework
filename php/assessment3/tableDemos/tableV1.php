<!DOCTYPE html>
<html>
<head>
<title>hard coded html</title>
</head>
<body>
<table border="1px">
<tr><th>#</th><th>%</th></tr>

<?php
$numbers = array( [1,11], [2, 22], [3, 33], [4,44]);

//var_dump( strval($numbers[0][0])) ;
$count = count( $numbers );
foreach ( $numbers as $index => $number)
{
    $first = strval($number[0]);
    $second = strval($number[1]);
    echo "<tr><td> $first </td><td> $second</td></tr>";
}
?>




</table>
</body>
<html>
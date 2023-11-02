<!DOCTYPE html>
<html>
<head>
<title>method-encapsulated array-driven html</title>
</head>
<body>
<table border="1px">
<?php

function echoRow( $index, $value) {
	echo "<tr><td>$index</td><td>$value</td></tr>";
};

$data = array(11,22,33,44);
echo '<tr><th>#</th><th>%</th></tr>';
for ( $i = 0; $i < count($data); $i++) {
	echoRow( $i +1, $data[$i] );
}
?>
</table>
</body>
<html>
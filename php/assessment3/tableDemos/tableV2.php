<!DOCTYPE html>
<html>
<head>
<title>array driven html</title>
</head>
<body>
<table border="1px">
<?php
$data = array(11,22,33,44);
echo '<tr><th>#</th><th>%</th></tr>';
for ( $i = 0; $i < count($data); $i++) {
	$place = $i +1;
	echo "<tr><td>$place</td><td>$data[$i]</td></tr>";
}

//echo "<tr><td>1</td><td>11</td></tr>";
//<tr><td>2</td><td>22</td></tr>
//<tr><td>3</td><td>33</td></tr>
//<tr><td>4</td><td>44</td></tr>
?>
</table>
</body>
<html>
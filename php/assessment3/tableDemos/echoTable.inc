<?php
function echoTable ( $data )
{
	echo '<table border="1px">';
	echo '<tr><th>#</th><th>%</th></tr>';
	//var_dump( strval($numbers[0][0])) ;
	$count = count( $data );
	foreach ( $data as $index => $datum)
	{
		$first = strval($datum[0]);
		$second = strval($datum[1]);
		echo "<tr><td> $first </td><td> $second</td></tr>";
	}
	echo '</table>';
}

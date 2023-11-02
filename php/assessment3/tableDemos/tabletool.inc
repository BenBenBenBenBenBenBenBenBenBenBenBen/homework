<?php
function echoTable($array) 
{
	echo '<table border="1px">';
	echo '<tr><th>#</th><th>%</th></tr>';

	foreach ($array as $index => $value)
	{
		
		echo "<tr><td>$index</td><td>$value</td></tr>";
	}
	echo '</table>';
}
<!DOCTYPE html>
<html>
<head>
<title>CLASS-encapsulated array-driven html</title>
</head>
<body>

<?php
class TableMaker {
	protected $data = array();
	public function add( $value ) {
		$this->data[ count($this->data) ] = $value;
	}
	protected function echoRow( $index, $value) {
		echo "<tr><td>$index</td><td>$value</td></tr>";
	}
	
	public function echotable() {
		echo '<table border="1px">';
		echo '<tr><th>#</th><th>%</th></tr>';
		for ( $i = 0; $i < count($this->data); $i++) {
			$this->echoRow( $i +1, $this->data[$i] );
		}
		echo '</table>';
	}
}
// Test
$tm = new TableMaker();
$tm->add(11);
$tm->add(22);
$tm->add(33);
$tm->add(44);
$tm->echotable();
?>
</table>
</body>
<html>
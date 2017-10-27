<?php

$tester= $_POST['arraytest'];
$test = json_decode($tester);

$to="jbowerbi@indiana.edu";
$subject="Someone just submitted data to the SQL Database for Jacob's Farm";
mail($to, $subject, "Data: ".$tester, "Content-type: text/plain; charset=utf-8");
$tester = substr($tester, 1, strlen($tester)-2);


$conn = new mysqli("DB_HOST", "DB_USER", "DB_PASSWORD", "DB_NAME", 'DB_PORT');
if ($conn->connect_errno) {
  echo "Failed to connect to MySQL: (" . $conn->connect_errno . ") " . $conn->connect_error;
	mail($to, $subject, "Connection Error", "Content-type: text/plain; charset=utf-8");

}

if (!$conn->query("INSERT INTO data VALUES (".$tester.")") == TRUE) {
  $errorvar = "failed: (" . $conn->errno . ") " . $conn->error;
	mail($to, $subject, $errorvar, "Content-type: text/plain; charset=utf-8");

}

$thread_id = $conn->thread_id;
$conn->kill(thread_id);
$conn->close();

?>

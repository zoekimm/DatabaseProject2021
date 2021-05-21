<?php

include 'open.php';

$airportCodeInput = $_POST["airportCodeInput"];

$sql = "DELETE FROM Airport WHERE airportCode = ?;";

if (empty($airportCodeInput)) {
    
    echo "ERROR: empty mandatory input.";

} else {
 
    if ($stmt = $conn->prepare($sql)) {
 
       $stmt->bind_param("s",  $airportCodeInput);

       if ($stmt->execute()) {
            if ($stmt->affected_rows != 0) {
                echo "airport code ".$airportCodeInput." deleted!<br>";
                
                printf("%d row deleted.\n", $stmt->affected_rows);
        }   else {
            echo "<br>Check your inputs again.<br>";
        }
       
       } else {
        echo $stmt->error;
        echo "<br>Execute failed. Check your inputs again.<br>";

       $stmt->close();
       }
 
    } else {

       echo "Prepare failed.<br>";
       $error = $conn->errno . ' ' . $conn->error;
       echo $error; 
    }
 
}

 $conn->close();
?>

<?php

include 'open.php';

$airlineCodeInput = $_POST["airlineCodeInput"];

$sql = "DELETE FROM Airline WHERE airlineCode = ?;";

if (empty($airlineCodeInput)) {
    
    echo "ERROR: empty mandatory input.";

} else {

    if ($stmt = $conn->prepare($sql)) {
 
       $stmt->bind_param("s", $airlineCodeInput);

        if ($stmt->execute()) {
            if ($stmt->affected_rows != 0) {
                echo "airline code ".$airlineCodeInput." has been succeessfully deleted!<br>";
            
                printf("%d row deleted.\n", $stmt->affected_rows);
        }   else {
            echo "<br>Check your inputs again.<br>";
        }

       } else {
 
        echo $stmt->error;
        echo "<br>Execute failed. Check your inputs again.<br>";

       }
        
       $stmt->close();
 
    } else {
 
       echo "Prepare failed.<br>";
       $error = $conn->errno . ' ' . $conn->error;
       echo $error; 
    }
 
}

 $conn->close();
?>

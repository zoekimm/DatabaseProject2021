<?php

include 'open.php';
$countryNameInput = $_POST["countryNameInput"];

$sql = "DELETE FROM Country WHERE countryName = ?;";

//Determine if any input was actually collected
if (empty($countryNameInput)) {
    
    echo "ERROR: empty mandatory input";

} else {
 
    //Prepare a statement that we can later execute. The ?'s are placeholders for
    //parameters whose values we will set before we run the query.
    if ($stmt = $conn->prepare($sql)) {
 
       $stmt->bind_param("s", $countryNameInput);

       //Run the actual query
        if ($stmt->execute()) {
            if ($stmt->affected_rows != 0) {
                echo $countryNameInput. " has been succeessfully deleted!<br>";
            
                printf("%d row deleted.\n", $stmt->affected_rows);
        }   else {
            echo "<br>Check your inputs again.<br>";
        }
       
       } else {
 
        echo $stmt->error;
       echo "<br>Execute failed. Check your inputs again.<br>";
 
       }
 
       //Close down the prepared statement
       $stmt->close();
 
    } else {
 
        //A problem occurred when preparing the statement; check for syntax errors
        //and misspelled attribute names in the statement string.
       echo "Prepare failed.<br>";
       $error = $conn->errno . ' ' . $conn->error;
       echo $error; 
    }
 
}

 //Close the connection created in open.php
 $conn->close();
?>
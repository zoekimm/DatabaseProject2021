<?php

include 'open.php';
$airlineCodeInput = $_POST["airlineCodeInput"];
$originCodeInput = $_POST["originCodeInput"];
$destinationCodeInput = $_POST["destinationCodeInput"];

$sql = "DELETE FROM Route WHERE airlineCode = ? and originCode = ? and  destinationCode = ?;";

//Determine if any input was actually collected
if (empty($airlineCodeInput) or empty($originCodeInput) or empty($destinationCodeInput)) {
    
    echo "ERROR: emtpy mandatory input";

} else {
 
    //Prepare a statement that we can later execute. The ?'s are placeholders for
    //parameters whose values we will set before we run the query.
    if ($stmt = $conn->prepare($sql)) {
 
       $stmt->bind_param("sss", $airlineCodeInput, $originCodeInput, $destinationCodeInput);

       //Run the actual query  
       
        if ($stmt->execute()) {
            if ($stmt->affected_rows != 0) {
                echo "Route from ".$originCodeInput." to ".$destinationCodeInput." operated by airline code ".$airlineCodeInput." has been succeessfully deleted!<br>";
            
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
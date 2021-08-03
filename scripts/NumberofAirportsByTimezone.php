<?php

include 'open.php';
$timezoneInput = $_POST["timezoneInput"];
$dataPoints = array();

if (empty($timezoneInput)) {
    
    echo "ERROR: emtpy input";

} else {
 
    if ($stmt = $conn->prepare("CALL NumberofAirportsByTimezone(?)")) {
 
       $stmt->bind_param("s", $timezoneInput);
 
       if ($stmt->execute()) {

          $result = $stmt->get_result();
 
          if ($result->num_rows == 0) {
 
             echo "No result; Please check your input value again";

          } else {

             echo "<table border=\"1px solid black\">";
             echo "<tr><th> Airport Name </th></tr>";

             while ($row = $result->fetch_row()) {
                echo "<tr>";
                echo "<td>".$row[0]."</td>";
                echo "</tr>";
                array_push($dataPoints, array("y" => $row[1], "label" => $row[0]));
             } 
             echo "</table>";
          }	 
 
       
          $result->free_result();
       
       } else {
 

          echo "Execute failed.<br>";
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

<?php

include 'open.php';
$countryNameInput = $_POST["countryNameInput"];
$dataPoints = array();

if (empty($countryNameInput)) {
    
    echo "ERROR: emtpy input";

} else {

    if ($stmt = $conn->prepare("CALL NumberofAirports(?)")) {
 
       $stmt->bind_param("s", $countryNameInput);
 
       if ($stmt->execute()) {

          $result = $stmt->get_result();
 
          if ($result->num_rows == 0) {

             echo "No result; Please check your input value again";

          } else {
      
             echo "<table border=\"1px solid black\">";
             echo "<tr><th> countryName </th> <th> total </th></tr>";

             while ($row = $result->fetch_row()) {
                echo "<tr>";
                echo "<td>".$row[0]."</td>";
                echo "<td>".$row[1]."</td>";
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

<!DOCTYPE HTML>
<html>
<head>
<script>
window.onload = function() {
 
var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	theme: "light2",
	title:{
		text: "Top Countries in Number of Airports"
	},
	axisY: {
		title: "Number of Airpots Based in Each Country"
	},
	data: [{
		type: "column",
		yValueFormatString: "#",
		dataPoints: <?php echo json_encode($dataPoints, JSON_NUMERIC_CHECK); ?>
	}]
});
chart.render();
 
}
</script>
</head>
<body>
<div id="chartContainer" style="height: 370px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>          






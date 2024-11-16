<!DOCTYPE html>
<html>
<head>
    <title>Booking Logs</title>
    <link rel="stylesheet" href="booking-logs.css"> </head>
<body>
    <h1>Booking Logs</h1>

    <?php
    // Database connection details (replace with your actual credentials)
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "TransportDB";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // SQL query to fetch booking logs
    $sql = "SELECT * FROM bookingLog";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<table>
            <tr>
                <th>Sr. No.</th>
                <th>Aadhar No.</th>
                <th>Phone No.</th>
                <th>Travel Mode</th>
                <th>Travel Vehicle</th>
                <th>Vehicle No.</th>
                <th>Tickets Booked</th>
                <th>Total Fare</th>
            </tr>";

        while($row = $result->fetch_assoc()) {
            echo "<tr>
                <td>" . $row["srNo"] . "</td>
                <td>" . $row["userAadhar"] . "</td>
                <td>" . $row["userPhoneNumber"] . "</td>
                <td>" . $row["travelMode"] . "</td>
                <td>" . $row["travelVehicle"] . "</td>
                <td>" . $row["vehicleNo"] . "</td>
                <td>" . $row["ticketsBooked"] . "</td>
                <td>" . $row["totalFare"] . "</td>
            </tr>";
        }

        echo "</table>";
    } else {
        echo "No booking logs found.";
    }

    $conn->close();
    ?>

</body>
</html>
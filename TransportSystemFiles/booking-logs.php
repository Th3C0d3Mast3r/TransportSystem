<!DOCTYPE html>
<html>
<head>
    <title>Booking Logs</title>
    <link rel="stylesheet" href="booking-logs.css"> </head>
    <style>
        /* Inline styles for better table presentation */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 18px;
            text-align: center;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
            font-family: 'Jomhuria', serif;
            font-size: 1.4em;

        }
        table th {
            background-color: #f4f4f4;
            font-family: 'Jomhuria', serif;
            font-weight: lighter;
            text-align: center;
            font-size: 2em;
            background-color: #333;
            color: #ddd;
        }
        table tr:nth-child(even) {
            background-color: #404040;
            color: #f1f1f1;
            transition: all 0.3s ease;
        }
        table tr{
            transition: all 0.3s ease;
        }
        table tr:hover {
            background-color: black;
            color:aquamarine;
            transform: scale(1.05);
        }
        h1 {
            text-align: center;
            margin-top: 20px;
            margin-bottom: 0px;
            font-family: 'Jomhuria', serif;
            font-weight: lighter;
            font-size: 6em;
        }
    </style>
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
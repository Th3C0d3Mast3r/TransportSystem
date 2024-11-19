<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers</title>
    <link rel="stylesheet" href="user-database.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Jomhuria&display=swap');
    </style>
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
</head>
<body>
    <h1>USERS</h1>

    <?php
    // Enable error reporting
    ini_set('display_errors', 1);
    error_reporting(E_ALL);

    // Database connection details
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "TransportDB"; // Correct database name

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // SQL query to fetch user data
    $sql = "SELECT * FROM userDatabase";
    $result = $conn->query($sql);

    if ($result && $result->num_rows > 0) {
        echo "<table>
            <tr>
                <th>SR. NO.</th>
                <th>USER NAME</th>
                <th>PH. NO.</th>
                <th>AADHAR NO.</th>
                <th>CREATION TIME</th>
            </tr>";

        $srNo = 1; // Initialize serial number
        while ($row = $result->fetch_assoc()) {
            echo "<tr>
                <td>" . $srNo++ . "</td>
                <td>" . htmlspecialchars($row["userName"]) . "</td>
                <td>" . htmlspecialchars($row["userPhoneNumber"]) . "</td>
                <td>" . htmlspecialchars($row["userAadhar"]) . "</td>
                <td>" . htmlspecialchars($row["createdAt"]) . "</td>
            </tr>";
        }

        echo "</table>";
    } else {
        echo "<p style='text-align: center;'>No customers found.</p>";
    }

    // Close the database connection
    $conn->close();
    ?>
</body>
</html>

<!DOCTYPE html>
<html>
<head>
    <title>Customers</title>
    <link rel="stylesheet" href="user-database.css"> </head>
<body>
    <h1>Customers</h1>

    <?php
    // Database connection details (replace with your actual credentials)
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "TrasnportDB";

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // SQL query to fetch user data
    $sql = "SELECT * FROM userDatabase";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<table>
            <tr>
                <th>SR. NO.</th>
                <th>USER NAME</th>
                <th>PH. NO.</th>
                <th>AADHAR NO.</th>
                <th>CREATION TIME</th>
            </tr>";

        $srNo = 1; // Initialize serial number
        while($row = $result->fetch_assoc()) {
            echo "<tr>
                <td>" . $srNo++ . "</td>
                <td>" . $row["userName"] . "</td>
                <td>" . $row["userPhoneNumber"] . "</td>
                <td>" . $row["userAadhar"] . "</td>
                <td>" . $row["createdAt"] . "</td>
            </tr>";
        }

        echo "</table>";
    } else {
        echo "No customers found.";
    }

    $conn->close();
    ?>

</body>
</html>
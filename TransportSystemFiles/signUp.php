<?php
// Start the session
session_start();

$servername = "localhost";
$username = "root";
$password = "qwertyuiop1234";
$dbname = "TransportDB";

// Create a connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    $userName = $_POST['userName'];
    $userPhoneNumber = $_POST['userPhoneNumber'];
    $userAadhar = $_POST['userAadhar'];
    $userPassword = $_POST['userPassword'];

    $sql = "SELECT * FROM userDatabase WHERE userAadhar = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $userAadhar);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo "Aadhar number is already registered!";
    } else {
        // Insert the new user into the database
        $sql = "INSERT INTO userDatabase (userName, userPhoneNumber, userAadhar, userPassword) VALUES (?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ssss", $userName, $userPhoneNumber, $userAadhar, $userPassword);

        if ($stmt->execute()) {
            echo "Sign up successful!";
            // Redirect or load another page
            header("Location: sign-in.html");
            exit();
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
    }

    $stmt->close();
}

$conn->close();
?>

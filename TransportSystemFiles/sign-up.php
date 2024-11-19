<?php
// Database connection parameters
$host = 'localhost';
$dbname = 'transportdb';
$username = 'root'; // Replace with your database username
$password = ''; // Replace with your database password

// Initialize variables
$error = "";
$success = "";

// Enable error reporting for debugging during development
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $userName = $_POST['userName'] ?? '';
    $userPhoneNumber = $_POST['userPhoneNumber'] ?? '';
    $userAadhar = $_POST['userAadhar'] ?? '';
    $userPassword = $_POST['userPassword'] ?? '';

    // Validate inputs
    if (empty($userName) || empty($userPhoneNumber) || empty($userAadhar) || empty($userPassword)) {
        $error = "All fields are required.";
    } elseif (!preg_match("/^[0-9]{12}$/", $userAadhar)) {
        $error = "Aadhar must be a 12-digit number.";
    } else {
        try {
            // Establish connection
            $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Insert user data
            $stmt = $conn->prepare("INSERT INTO userDatabase (userName, userPhoneNumber, userAadhar, userPassword) 
                                    VALUES (:userName, :userPhoneNumber, :userAadhar, :userPassword)");
            $stmt->bindParam(':userName', $userName);
            $stmt->bindParam(':userPhoneNumber', $userPhoneNumber);
            $stmt->bindParam(':userAadhar', $userAadhar);
            $stmt->bindParam(':userPassword', $userPassword);

            if ($stmt->execute()) {
                $success = "Signup successful! You can now log in.";
            } else {
                $error = "Failed to insert data.";
            }
        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                $error = "Aadhar number already registered.";
            } else {
                $error = "Error: " . $e->getMessage();
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="sign-up.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
    <div class="sign-up-container">
        <h1>SIGN UP</h1>

        <!-- Display error or success messages -->
        <?php if ($error): ?>
            <p class="error" style="color: red;"><?= htmlspecialchars($error) ?></p>
        <?php endif; ?>
        <?php if ($success): ?>
            <p class="success" style="color: green;"><?= htmlspecialchars($success) ?></p>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="input-group">
                <label><i class="fas fa-user"></i> USERNAME</label>
                <input type="text" name="userName" placeholder="Username" required>
            </div>
            <div class="input-group">
                <label><i class="fas fa-phone"></i> PHONE NUMBER</label>
                <input type="tel" name="userPhoneNumber" placeholder="Phone Number" required>
            </div>
            <div class="input-group">
                <label><i class="fas fa-id-card"></i> AADHAR NUMBER</label>
                <input type="text" name="userAadhar" placeholder="Aadhar Number" required pattern="[0-9]{12}" title="Aadhar must be a 12-digit number.">
            </div>
            <div class="input-group">
                <label><i class="fas fa-lock"></i> PASSWORD</label>
                <input type="password" name="userPassword" placeholder="Password" required>
            </div>
            <button type="submit" class="sign-up-btn">SIGN UP</button>
        </form>
        <p><a href="#">Forgot password?</a></p>
        <p>Already have an account? <a href="sign-in.php">SIGN IN</a></p>
    </div>
</body>
</html>

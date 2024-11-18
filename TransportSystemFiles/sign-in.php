<?php
// Enable error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Database connection parameters
$host = 'localhost';
$dbname = 'TransportDB';
$username = 'root'; // Replace with your database username
$password = ''; // Replace with your database password (empty if no password set)

// Initialize variables
$error = "";
$success = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $userAadhar = $_POST['userAadhar'];
    $userPassword = $_POST['userPassword'];

    // Validate inputs
    if (empty($userAadhar) || empty($userPassword)) {
        $error = "Aadhar number and password are required.";
    } else {
        try {
            // Establish connection
            $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Check if Aadhar belongs to an employee (special cases)
            $employeeCredentials = [
                'AD001' => 'Devesh',
                'AD002' => 'Atharv',
                'AD003' => 'Yug'
            ];

            if (array_key_exists($userAadhar, $employeeCredentials) && $userPassword === $employeeCredentials[$userAadhar]) {
                // If Aadhar is for an employee, redirect to the admin dashboard
                header("Location: admin-dashboard.html");
                exit();
            } else {
                // If Aadhar is not for an employee, check the userDatabase
                $stmt = $conn->prepare("SELECT * FROM userDatabase WHERE userAadhar = :userAadhar AND userPassword = :userPassword");
                $stmt->bindParam(':userAadhar', $userAadhar);
                $stmt->bindParam(':userPassword', $userPassword);
                $stmt->execute();

                // Check if user exists and credentials match
                if ($stmt->rowCount() > 0) {
                    // User is authenticated, redirect to booking page
                    header("Location: booking.html");
                    exit();
                } else {
                    $error = "Invalid Aadhar number or password.";
                }
            }
        } catch (PDOException $e) {
            $error = "Error: " . $e->getMessage();
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <link rel="stylesheet" href="sign-in.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <script defer src="sign-in.js"></script>
</head>
<body>
    <div class="sign-in-container">
        <h1>SIGN IN</h1>

        <!-- Display error or success messages -->
        <?php if ($error): ?>
            <p class="error" style="color: red;"><?= htmlspecialchars($error) ?></p>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="input-group">
                <label id="user"><i class="fas fa-user"></i> AADHAR NUMBER</label>
                <input type="text" name="userAadhar" placeholder="Aadhar Number" required>
            </div>
            <div class="input-group">
                <label><i class="fas fa-lock"></i> PASSWORD</label>
                <input type="password" name="userPassword" placeholder="Password" required>
            </div>
            <button type="submit" class="sign-in-btn">SIGN IN</button>
        </form>

        <p><a href="#">Forgot password?</a></p>
        <p>Don't have an account? <a href="sign-up.html">SIGN UP</a></p>
    </div>
</body>
</html>

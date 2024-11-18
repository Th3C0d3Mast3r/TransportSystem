<?php
// Start session if not already active
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Enable error display for debugging
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Database connection
$servername = "localhost";
$username = "root";
$password = ""; // Adjust if your MySQL root user has a password
$dbname = "TransportDB";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// Handle POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $aadhar = trim($_POST['aadhar']);
    $password = trim($_POST['password']);

    if (empty($aadhar) || empty($password)) {
        echo "<script>
                alert('Please fill in all fields.');
                window.location.href = 'sign-in.html';
              </script>";
        exit();
    }

    try {
        $stmt = $conn->prepare("SELECT userName FROM userDatabase WHERE userAadhar = :aadhar AND userPassword = :password");
        $stmt->bindParam(':aadhar', $aadhar, PDO::PARAM_STR);
        $stmt->bindParam(':password', $password, PDO::PARAM_STR);
        $stmt->execute();

        if ($stmt->rowCount() > 0) {
            $user = $stmt->fetch(PDO::FETCH_ASSOC);
            $_SESSION['userName'] = $user['userName'];
            echo "<script>
                    localStorage.setItem('userName', '{$user['userName']}');
                    window.location.href = 'booking.html';
                  </script>";
        } else {
            echo "<script>
                    alert('Invalid Aadhar Number or Password.');
                    window.location.href = 'sign-in.html';
                  </script>";
        }
    } catch (PDOException $e) {
        error_log("Query error: " . $e->getMessage());
        echo "<script>
                alert('An error occurred. Please try again later.');
              </script>";
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
        <form id="signInForm" action="sign-in.php" method="post">
            <div class="input-group">
                <label id="user"><i class="fas fa-user"></i> USER</label>
                <input type="text" id="aadharInput" name="aadhar" placeholder="Aadhar Number" required>
            </div>
            <div class="input-group">
                <label><i class="fas fa-lock"></i> PASSWORD</label>
                <input type="password" id="passwordInput" name="password" placeholder="Password" required>
            </div>
            <button type="submit" class="sign-in-btn" onclick="window.location.href='booking.html'">SIGN IN</button>
        </form>
        <p><a href="#">Forgot password?</a></p>
        <p>Don't have an account? <a href="sign-up.html">SIGN UP</a></p>
    </div>
</body>
</html>

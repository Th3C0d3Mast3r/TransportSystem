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
    $userAadhar = $_POST['userAadhar'] ?? '';
    $userPassword = $_POST['userPassword'] ?? '';

    // Validate inputs
    if (empty($userAadhar) || empty($userPassword)) {
        $error = "Both Aadhar and Password are required.";
    } elseif (!preg_match("/^[0-9]{12}$/", $userAadhar)) {
        $error = "Invalid Aadhar number. It must be a 12-digit number.";
    } else {
        try {
            // Establish connection
            $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
            $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            // Fetch user data
            $stmt = $conn->prepare("SELECT userName, userPassword FROM userDatabase WHERE userAadhar = :userAadhar");
            $stmt->bindParam(':userAadhar', $userAadhar);
            $stmt->execute();

            // Check if user exists
            if ($stmt->rowCount() > 0) {
                $user = $stmt->fetch(PDO::FETCH_ASSOC);

                // Verify password (adjust if using hashing)
                if ($user['userPassword'] === $userPassword) { 
                    // Successful login
                    session_start();
                    $_SESSION['userName'] = $user['userName'];
                    $success = "Sign-in successful! Redirecting to the booking page...";
                    echo "<script>
                            localStorage.setItem('userName', " . json_encode($user['userName']) . ");
                            localStorage.setItem('userAadhar', " . json_encode($userAadhar) . ");
                            window.location.href = 'booking.html';
                          </script>";
                    exit();
                }
                else {
                    $error = "Incorrect password.";
                }
            } else {
                $error = "Aadhar not found. Please sign up.";
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
</head>
<body>
    <div class="sign-in-container">
        <h1>SIGN IN</h1>
        <?php if (!empty($error)): ?>
            <p class="error-message"><?php echo htmlspecialchars($error); ?></p>
        <?php elseif (!empty($success)): ?>
            <p class="success-message"><?php echo htmlspecialchars($success); ?></p>
        <?php endif; ?>
        <form id="signInForm" action="sign-in.php" method="post">
            <div class="input-group">
                <label for="userAadhar"><i class="fas fa-id-card"></i> Aadhar</label>
                <input type="text" id="userAadhar" name="userAadhar" placeholder="Enter your 12-digit Aadhar" required>
            </div>
            <div class="input-group">
                <label for="userPassword"><i class="fas fa-lock"></i> Password</label>
                <input type="password" id="userPassword" name="userPassword" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="sign-in-btn">SIGN IN</button>
        </form>
        <p><a href="#">Forgot password?</a></p>
        <p>Don't have an account? <a href="sign-up.php">SIGN UP</a></p>
    </div>
</body>
</html>

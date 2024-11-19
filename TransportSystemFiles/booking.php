<?php
// Database connection
$host = 'localhost';
$dbname = 'transportdb';
$username = 'root';
$password = '';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Fetch form data
    $startLocation = $_POST['startLocation'] ?? '';
    $destination = $_POST['destination'] ?? '';
    $transport = strtoupper($_POST['transport'] ?? '');

    // Validate inputs
    if (empty($startLocation) || empty($destination) || empty($transport)) {
        echo "<script>
                alert('All fields are required.');
                window.location.href = 'booking.html';
              </script>";
        exit();
    }

    // Determine the table name based on transport
    $tableName = match ($transport) {
        'PLANE' => 'planeRoute',
        'TRAIN' => 'trainRoute',
        'BUS' => 'busRoute',
        default => '',
    };

    if (empty($tableName)) {
        echo "<script>
                alert('Invalid transport type.');
                window.location.href = 'booking.html';
              </script>";
        exit();
    }

    // Check route availability
    $route = $startLocation . '-' . $destination;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM $tableName WHERE route = :route");
    $stmt->bindParam(':route', $route, PDO::PARAM_STR);
    $stmt->execute();
    $routeExists = $stmt->fetchColumn();

    if ($routeExists > 0) {
        // Route exists
        echo "<script>
                alert('Route available! Proceeding to booking...');
                window.location.href = 'bookTickets.html';
              </script>";
    } else {
        // Route does not exist
        echo "<script>
                alert('Route not available. Please choose another.');
                window.location.href = 'booking.html';
              </script>";
    }
} catch (PDOException $e) {
    echo "<script>
            alert('Error connecting to the database: " . addslashes($e->getMessage()) . "');
            window.location.href = 'booking.html';
          </script>";
}
?>

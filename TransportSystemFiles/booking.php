<?php
header('Content-Type: application/json');

// Database connection parameters
$host = 'localhost';
$dbname = 'transportdb';
$username = 'root';
$password = '';

try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Helper function to validate and sanitize inputs
    function sanitizeInput($input) {
        return htmlspecialchars(trim($input));
    }

    // Route validation action
    if (isset($_POST['action']) && $_POST['action'] === 'validateRoute') {
        $startLocation = strtoupper(sanitizeInput($_POST['startLocation'] ?? ''));
        $destination = strtoupper(sanitizeInput($_POST['destination'] ?? ''));
        $transport = strtoupper(sanitizeInput($_POST['transport'] ?? ''));

        if (empty($startLocation) || empty($destination) || empty($transport)) {
            echo json_encode(['routeAvailable' => false, 'error' => 'All fields are required.']);
            exit();
        }

        $tableMapping = [
            'PLANE' => 'planeRoute',
            'TRAIN' => 'trainRoute',
            'BUS' => 'busRoute',
            'CAB' => 'cabRoute'
        ];

        $tableName = $tableMapping[$transport] ?? null;
        if (!$tableName) {
            echo json_encode(['routeAvailable' => false, 'error' => 'Invalid transport type.']);
            exit();
        }

        $route = $startLocation . '-' . $destination;

        $stmt = $conn->prepare("SELECT COUNT(*) FROM $tableName WHERE route = :route");
        $stmt->bindParam(':route', $route, PDO::PARAM_STR);
        $stmt->execute();
        $routeExists = $stmt->fetchColumn();

        echo json_encode(['routeAvailable' => $routeExists > 0]);
        exit();
    }

    // Ticket booking action
    if (isset($_POST['action']) && $_POST['action'] === 'bookTickets') {
        $userAadhar = sanitizeInput($_POST['userAadhar'] ?? '');
        $numTickets = intval($_POST['numTickets'] ?? 1);
        $travelType = sanitizeInput($_POST['travelType'] ?? '');
        $travelMode = sanitizeInput($_POST['travelMode'] ?? '');

        if (empty($userAadhar) || $numTickets <= 0 || empty($travelType) || empty($travelMode)) {
            echo json_encode(['status' => 'error', 'message' => 'Invalid booking details.']);
            exit();
        }

        $routeParts = explode(' to ', $travelType);
        if (count($routeParts) < 3) {
            echo json_encode(['status' => 'error', 'message' => 'Invalid travel type format.']);
            exit();
        }

        $startLocation = $routeParts[0];
        $destination = $routeParts[1];
        $transport = strtoupper($routeParts[2]);
        $route = $startLocation . '-' . $destination;

        $stmt = $conn->prepare("SELECT userName, userPhoneNumber FROM userDatabase WHERE userAadhar = :userAadhar");
        $stmt->bindParam(':userAadhar', $userAadhar);
        $stmt->execute();
        $userData = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$userData) {
            echo json_encode(['status' => 'error', 'message' => 'User not found.']);
            exit();
        }

        $fareMapping = [
            'BUS' => ['table' => 'busRoute', 'columns' => ['AC' => 'fareAC', 'NON-AC' => 'fareNonAC']],
            'CAB' => ['table' => 'cabRoute', 'columns' => ['MINI' => 'fareMini', 'PRIME' => 'farePrime', 'SUV' => 'fareSUV']],
            'TRAIN' => ['table' => 'trainRoute', 'columns' => ['SLEEPER' => 'fareSleeper', '3 TIER' => 'fare3Tier', '2 TIER' => 'fare2Tier', '1 CLASS' => 'fare1Class']],
            'PLANE' => ['table' => 'planeRoute', 'columns' => ['ECONOMY' => 'fareEconomy', 'FIRST CLASS' => 'fareFirstClass', 'PRIVATE' => 'farePrivate']]
        ];

        $transportData = $fareMapping[$transport] ?? null;
        if (!$transportData || !isset($transportData['columns'][$travelMode])) {
            echo json_encode(['status' => 'error', 'message' => 'Invalid transport or mode.']);
            exit();
        }

        $tableName = $transportData['table'];
        $fareColumn = $transportData['columns'][$travelMode];

        $stmt = $conn->prepare("SELECT $fareColumn AS fare FROM $tableName WHERE route = :route");
        $stmt->bindParam(':route', $route);
        $stmt->execute();
        $routeData = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$routeData) {
            echo json_encode(['status' => 'error', 'message' => 'Route or fare not found.']);
            exit();
        }

        $totalFare = $routeData['fare'] * $numTickets;
        $vehicleNo = strtoupper(substr(md5(uniqid(rand(), true)), 0, 10));

        $stmt = $conn->prepare("
            INSERT INTO bookingLog (
                userAadhar, userPhoneNumber, travelMode, travelVehicle, vehicleNo, ticketsBooked, totalFare
            ) VALUES (
                :userAadhar, :userPhoneNumber, :travelMode, :travelVehicle, :vehicleNo, :ticketsBooked, :totalFare
            )
        ");
        $stmt->execute([
            ':userAadhar' => $userAadhar,
            ':userPhoneNumber' => $userData['userPhoneNumber'],
            ':travelMode' => $travelMode,
            ':travelVehicle' => $transport,
            ':vehicleNo' => $vehicleNo,
            ':ticketsBooked' => $numTickets,
            ':totalFare' => $totalFare
        ]);

        echo json_encode([
            'status' => 'success',
            'message' => 'Booking successful!',
            'totalFare' => $totalFare,
            'vehicleNo' => $vehicleNo
        ]);
        exit();
    }

} catch (PDOException $e) {
    error_log($e->getMessage()); // Logs to server logs
    echo json_encode([
        'status' => 'error',
        'message' => 'Database error occurred.',
        'details' => $e->getMessage() // Include this for debugging
    ]);
    exit();
}
?>
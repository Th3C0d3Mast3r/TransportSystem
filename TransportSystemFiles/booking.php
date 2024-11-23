<?php
// Connect to the database
$conn = new mysqli('localhost', 'root', '', 'TransportDB');

// Check connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Database connection failed: " . $conn->connect_error]));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'];

    if ($action === 'validateRoute') {
        // Validate the route and fetch travel types
        $startLocation = $conn->real_escape_string($_POST['startLocation']);
        $destination = $conn->real_escape_string($_POST['destination']);
        $transport = $conn->real_escape_string($_POST['transport']);
        $route = strtoupper($startLocation . '-' . $destination);

        // Fetch travelMode options based on transport
        $tableMapping = [
            'BUS' => 'busRoute',
            'CAB' => 'cabRoute',
            'TRAIN' => 'trainRoute',
            'PLANE' => 'planeRoute'
        ];

        $tableName = $tableMapping[$transport] ?? null;
        if (!$tableName) {
            echo json_encode(['routeAvailable' => false, 'message' => 'Invalid transport mode.']);
            exit;
        }

        $query = "SELECT DISTINCT travelMode FROM $tableName WHERE route = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param("s", $route);
        $stmt->execute();
        $result = $stmt->get_result();

        $travelModes = [];
        while ($row = $result->fetch_assoc()) {
            $travelModes[] = $row['travelMode'];
        }

        if (empty($travelModes)) {
            echo json_encode(['routeAvailable' => false, 'message' => 'Route not available.']);
        } else {
            echo json_encode(['routeAvailable' => true, 'travelModes' => $travelModes]);
        }

        $stmt->close();
    } elseif ($action === 'bookTickets') {
        // Handle booking
        $userAadhar = $conn->real_escape_string($_POST['userAadhar']);
        $numTickets = intval($_POST['numTickets']);
        $travelType = $conn->real_escape_string($_POST['travelType']);
        $travelMode = $conn->real_escape_string($_POST['travelMode']);
        $vehicleNo = $conn->real_escape_string($_POST['vehicleNo']);

        // Check if user exists
        $queryUser = "SELECT userPhoneNumber FROM userDatabase WHERE userAadhar = ?";
        $stmt = $conn->prepare($queryUser);
        $stmt->bind_param("s", $userAadhar);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            echo json_encode(["status" => "error", "message" => "User not found."]);
            exit;
        }

        $userPhoneNumber = $result->fetch_assoc()['userPhoneNumber'];
        $stmt->close();

        // Calculate fare
        $tableMapping = [
            'BUS' => 'busRoute',
            'CAB' => 'cabRoute',
            'TRAIN' => 'trainRoute',
            'PLANE' => 'planeRoute'
        ];

        $fareColumnMapping = [
            'BUS' => $travelType === 'AC' ? 'fareAC' : 'fareNonAC',
            'CAB' => "fare" . ucfirst($travelMode),
            'TRAIN' => "fare" . str_replace(" ", "", $travelMode),
            'PLANE' => "fare" . str_replace(" ", "", $travelMode)
        ];

        $tableName = $tableMapping[$transport];
        $fareColumn = $fareColumnMapping[$transport];

        $queryFare = "SELECT $fareColumn AS fare FROM $tableName WHERE route = ? AND travelMode = ?";
        $stmt = $conn->prepare($queryFare);
        $stmt->bind_param("ss", $route, $travelMode);
        $stmt->execute();
        $fareResult = $stmt->get_result();

        if ($fareResult->num_rows === 0) {
            echo json_encode(['status' => 'error', 'message' => 'Fare not found for the specified route.']);
            exit();
        }

        $fareData = $fareResult->fetch_assoc();
        $farePerTicket = $fareData['fare'];
        $totalFare = $numTickets * $farePerTicket;

        // Insert into bookingLog
        $insertBooking = "INSERT INTO bookingLog (userAadhar, userPhoneNumber, travelMode, travelVehicle, vehicleNo, ticketsBooked, totalFare)
                          VALUES (?, ?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($insertBooking);
        $stmt->bind_param("sssssis", $userAadhar, $userPhoneNumber, $transport, $travelType, $vehicleNo, $numTickets, $totalFare);

        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Booking successful!", "totalFare" => $totalFare]);
        } else {
            echo json_encode(["status" => "error", "message" => "Booking failed: " . $stmt->error]);
        }

        $stmt->close();
    }
}
$conn->close();
?>

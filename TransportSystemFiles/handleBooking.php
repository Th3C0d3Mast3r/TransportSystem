<!-- <?php
// Connect to the database
$conn = new mysqli('localhost', 'root', '', 'TransportDB');

// Check connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Database connection failed: " . $conn->connect_error]));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $userAadhar = $_POST['userAadhar'];
    $numTickets = intval($_POST['numTickets']);
    $travelType = $_POST['travelType'];
    $travelMode = $_POST['travelMode'];

    // Get user phone number based on Aadhar
    $queryUser = "SELECT userPhoneNumber FROM userDatabase WHERE userAadhar = ?";
    $stmt = $conn->prepare($queryUser);
    $stmt->bind_param("s", $userAadhar);
    $stmt->execute();
    $result = $stmt->get_result();
    $userPhoneNumber = $result->fetch_assoc()['userPhoneNumber'];
    $stmt->close();

    if (!$userPhoneNumber) {
        echo json_encode(["status" => "error", "message" => "User not found."]);
        exit;
    }

    // Calculate fare per ticket (Example value)
    $farePerTicket = 500; 
    $totalFare = $numTickets * $farePerTicket;

    // Insert into bookingLog
    $insertBooking = "INSERT INTO bookingLog (userAadhar, userPhoneNumber, travelMode, travelVehicle, vehicleNo, ticketsBooked, totalFare)
                      VALUES (?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($insertBooking);
    $vehicleNo = "N/A"; // Replace with actual vehicle number logic
    $stmt->bind_param("sssssid", $userAadhar, $userPhoneNumber, $travelMode, $travelType, $vehicleNo, $numTickets, $totalFare);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Booking successful!"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Booking failed: " . $stmt->error]);
    }

    $stmt->close();
}

$conn->close();
?> -->

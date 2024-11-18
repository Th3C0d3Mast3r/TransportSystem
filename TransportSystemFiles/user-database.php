<?php
// Database connection parameters
$host = 'localhost';
$dbname = 'transportdb';
$username = 'root'; // Replace with your database username
$password = 'qwertyuiop1234'; // Replace with your database password

try {
    // Establishing connection
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Fetching user data (excluding password)
    $stmt = $conn->prepare("SELECT userName, userPhoneNumber, userAadhar, createdAt FROM userDatabase");
    $stmt->execute();

    // Fetch all users
    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);

} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
    die();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - View Users</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        h1 {
            color: #333;
        }
    </style>
</head>
<body>
    <h1>Registered Users</h1>

    <?php if (count($users) > 0): ?>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Phone Number</th>
                    <th>Aadhar</th>
                    <th>Registration Date</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($users as $user): ?>
                    <tr>
                        <td><?= htmlspecialchars($user['userName']) ?></td>
                        <td><?= htmlspecialchars($user['userPhoneNumber']) ?></td>
                        <td><?= htmlspecialchars($user['userAadhar']) ?></td>
                        <td><?= htmlspecialchars($user['createdAt']) ?></td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>No users found in the database.</p>
    <?php endif; ?>
</body>
</html>

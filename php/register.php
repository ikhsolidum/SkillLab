<?php
// Allow cross-origin requests
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header('Content-Type: application/json');

// Database connection details
$servername = "localhost";
$username = "ikhsolidum_db";
$password = "ds!q6I399";
$dbname = "ikhsolidum_db";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Database connection failed: " . $conn->connect_error]);
    exit();
}

// Get POST data
$user = $_POST['username'] ?? null;
$email = $_POST['email'] ?? null;
$pass = $_POST['password'] ?? null;

// Validate inputs
if (!$user || !$email || !$pass) {
    echo json_encode(["status" => "error", "message" => "All fields are required."]);
    exit();
}

// Prepare SQL statement
$sql = "INSERT INTO userdetails (username, email, password) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    echo json_encode(["status" => "error", "message" => "Failed to prepare the SQL statement: " . $conn->error]);
    exit();
}

// Bind parameters and execute statement
$stmt->bind_param("sss", $user, $email, $pass);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "User registered successfully."]);
} else {
    echo json_encode(["status" => "error", "message" => "Failed to register user: " . $stmt->error]);
}

// Close connections
$stmt->close();
$conn->close();
?>

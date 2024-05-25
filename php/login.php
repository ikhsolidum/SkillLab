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
$email = $_POST['email'] ?? null;
$pass = $_POST['password'] ?? null;

// Validate inputs
if (!$email || !$pass) {
    echo json_encode(["status" => "error", "message" => "Email and password are required."]);
    exit();
}

// Prepare SQL statement
$sql = "SELECT * FROM userdetails WHERE email = ? AND password = ?";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    echo json_encode(["status" => "error", "message" => "Failed to prepare the SQL statement: " . $conn->error]);
    exit();
}

// Bind parameters and execute statement
$stmt->bind_param("ss", $email, $pass);
$stmt->execute();
$result = $stmt->get_result();

// Check if user exists
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode(["status" => "success", "message" => "Login successful"]);
} else {
    echo json_encode(["status" => "error", "message" => "Invalid email or password"]);
}

// Close connections
$stmt->close();
$conn->close();
?>

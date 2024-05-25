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
$email = $_POST['email'] ?? ''; // Receive email from POST data
$courseName = $_POST['course'] ?? ''; // Receive course name from POST data

// Prepare SQL statement to delete the course
$sql = "DELETE FROM courseslist WHERE email = ? AND coursename = ?";
$stmt = $conn->prepare($sql);

if (!$stmt) {
    echo json_encode(["status" => "error", "message" => "Failed to prepare the SQL statement: " . $conn->error]);
    exit();
}

// Bind parameters and execute statement
$stmt->bind_param("ss", $email, $courseName);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Course deleted successfully."]);
} else {
    echo json_encode(["status" => "error", "message" => "Failed to delete course: " . $stmt->error]);
}

// Close connections
$stmt->close();
$conn->close();
?>

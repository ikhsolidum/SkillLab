<?php
include_once 'connect.php';
include_once 'users.php';

// Instantiate database and object
$database = new Database();
$db = $database->getConnection();
$user = new Users($db);

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the user ID and image data from the request body
    $userId = $_POST['userId'];
    $imageData = file_get_contents($_FILES['image']['tmp_name']);

    // Update the user's profile image
    if ($user->updateProfileImage($userId, $imageData)) {
        http_response_code(200);
        echo json_encode(['message' => 'Profile image uploaded successfully']);
    } else {
        http_response_code(500);
        echo json_encode(['message' => 'Failed to upload profile image']);
    }
} else {
    http_response_code(405);
    echo json_encode(['message' => 'Method Not Allowed']);
}


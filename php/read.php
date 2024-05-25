<?php
// Allow from any origin
if (isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Max-Age: 86400');
}

// Access-Control headers are received during OPTIONS requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
    exit(0);
}

// Database connection and object files
include_once 'connect.php';
include_once 'users.php';


// Instantiate database and object
$database = new Database();
$db = $database->getConnection();
$user = new Users($db);

// Read users
$user_arr = $user->read();

// Check if records found
if (!empty($user_arr)) {
    // Hash the passwords before returning the data
    foreach ($user_arr as &$row) {
        $row['password'] = password_hash($row['password'], PASSWORD_DEFAULT);
    }

    http_response_code(200);
    echo json_encode($user_arr);
} else {
    http_response_code(404);
    echo json_encode(array("message" => "No user found."));
}
?>
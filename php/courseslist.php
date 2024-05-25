<?php
class CoursesList {
    private $conn;
    private $table_name = "courseslist";

    public $id;
    public $email;
    public $coursename;

    public function __construct($db) {
        $this->conn = $db;
    }

    function create() {
        $data = json_decode(file_get_contents('php://input'), true);
        if (isset($data['email']) && isset($data['courses']) && is_array($data['courses'])) {
            $this->email = htmlspecialchars(strip_tags($data['email']));
            foreach ($data['courses'] as $course) {
                if (isset($course['name'])) {
                    $this->coursename = htmlspecialchars(strip_tags($course['name']));
                    $query = "INSERT INTO " . $this->table_name . " (email, coursename) VALUES (?, ?)";
                    $stmt = $this->conn->prepare($query);
                    $stmt->bind_param("ss", $this->email, $this->coursename);
                    if (!$stmt->execute()) {
                        error_log("Error executing query: " . $stmt->error);
                        return false;
                    }
                }
            }
            return true;
        }
        return false;
    }

    function read() {
        $query = "SELECT id, email, coursename FROM " . $this->table_name . " ORDER BY id ASC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        return $result;
    }
}

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

// Add the X-Content-Type-Options header
header("X-Content-Type-Options: nosniff");
?>
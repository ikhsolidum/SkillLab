<?php
class Users {
    private $conn;
    private $table_name = "userdetails";

    public $id;
    public $username;
    public $password;
    

    public function __construct($db) {
        $this->conn = $db;
    }

    function create_secure() {
        $check_query = "SELECT username FROM " . $this->table_name . " WHERE username = ?";
        $check_stmt = $this->conn->prepare($check_query);
        $check_stmt->bindParam(1, $this->username);
        $check_stmt->execute();

        if ($check_stmt->rowCount() > 0) {
            return false; // Username already exists
        }

        $hashed_password = password_hash($this->password, PASSWORD_DEFAULT);

        $query = "INSERT INTO " . $this->table_name . " SET username = :username, password = :password";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":username", $this->username);
        $stmt->bindParam(":password", $hashed_password);

        if ($stmt->execute()) {
            return true; // Record inserted successfully
        }

        return false; // Error in execution
    }

    function create() {
        $check_query = "SELECT id FROM " . $this->table_name . " WHERE username = ?";
        $check_stmt = $this->conn->prepare($check_query);
        $check_stmt->bindParam(1, $this->username);
        $check_stmt->execute();

        if ($check_stmt->rowCount() > 0) {
            return false; // Username already exists
        }

        $query = "INSERT INTO " . $this->table_name . " SET username = :username, password = :password";
        $stmt = $this->conn->prepare($query);
        $this->username = htmlspecialchars(strip_tags($this->username));
        $this->password = htmlspecialchars(strip_tags($this->password));
        $stmt->bindParam(":username", $this->username);
        $stmt->bindParam(":password", $this->password);

        if ($stmt->execute()) {
            return true; // Record inserted successfully
        }

        return false; // Error in execution
    }

    function validate() {
        $query = "SELECT * FROM " . $this->table_name . " WHERE username = ? AND password = ?";
        $stmt = $this->conn->prepare($query);
        $this->username = htmlspecialchars(strip_tags($this->username));
        $this->password = htmlspecialchars(strip_tags($this->password));
        $stmt->bindParam(1, $this->username);
        $stmt->bindParam(2, $this->password);

        if ($stmt->execute()) {
            if ($stmt->rowCount() == 1) {
                return true; // Valid credentials
            }
        }

        return false; // Invalid credentials or error
    }

    function read() {
        $query = "SELECT id, username, email, password FROM " . $this->table_name . " ORDER BY id ASC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
        // Hash the passwords before returning the data
        foreach ($result as &$row) {
            $row['password'] = password_hash($row['password'], PASSWORD_DEFAULT);
        }
    
        return $result;
    }
    
    function updateProfileImage($userId, $imageData) {
        $query = "UPDATE " . $this->table_name . " SET profile_image = ? WHERE id = ?";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $imageData, PDO::PARAM_LOB);
        $stmt->bindParam(2, $userId);
        if ($stmt->execute()) {
            return true;
        }
        return false;
    }
    
}
?>
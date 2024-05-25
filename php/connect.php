<?php
class Database {
    private $host = "localhost";
    private $db_name = "ikhsolidum_db";
    private $username = "ikhsolidum_db";
    private $password = "ds!q6I399";
    public $conn;

    // Get the database connection
    public function getConnection() {
        $this->conn = null;
        try {
            $this->conn = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name, $this->username, $this->password);
            $this->conn->exec("set names utf8");
        } catch(PDOException $exception) {
            echo "Connection error: " . $exception->getMessage();
        }
        return $this->conn;
    }
}
?>
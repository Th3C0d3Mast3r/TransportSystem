<?php
    session_start();

    // assigning the variable names and all that will be used below
    $servername="localhost";
    $username="root";
    $password="qwertyuiop1234";
    $dbname="TransportDB";

    $conn=new mysqli($servername, $username, $password, $dbname);

    if($conn -> connect_error) die("Connection Failed: " .$$conn -> connect_error);

    $conn->close();

    // check if the user clicked the submit button or no
    if($_SERVER["REQUEST METHOD"]=="POST"){
        $userAadhar=$_POST['userAadhar'];
        $password=$_POST['userPassword'];

        // THE QUERY
        $query="SELECT * FROM userDatabase WHERE userAadhar=? AND userPassword=?";
        $statement=$conn->prepare($sql);
        $stmt->bind_param("ss", $userAadhar, $userPassword);
        $stmt->execute();
        $result = $stmt->get_result();

        if($result -> num_rows > 0){
            $_SESSION["userAadhar"]=$userAadhar;
            echo "Login Successful for Aadhar Number {$userAadhar}";

            // redirecting to a new page
            header("Location: booking.html");
            exit();
        }   // means there is some answer for the same

        else echo "Invalid Credentials!";
        $stmt->close();
    }

?>
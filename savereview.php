<?php
    include 'connect.php';
    date_default_timezone_set('Asia/Ho_Chi_Minh');
    if($_SERVER['REQUEST_METHOD']=='POST')
    {
        $username=$_POST['username'];
        $idreview=$_POST['idreview'];
        $ngayluu=date('Y-m-d H:i:s');
        require_once 'connect.php';
        
        $sql="SELECT * FROM save_table WHERE username='$username' and idreview='$idreview'";
        $response=$conn->query($sql);
        $row=mysqli_fetch_assoc($response);
        $sql="INSERT INTO save_table (username,idreview,ngayluu) VALUES ('$username','$idreview','$ngayluu')";

        if($row||$conn->query($sql)===TRUE)
        {
            if($row) 
            $conn->query("UPDATE save_table set ngayluu='$ngayluu'");
            $result['success']='1';
            echo json_encode($result);
            mysqli_close($conn);
        }
        
        else{
            $result['success']='0';
            echo json_encode($result);
            mysqli_close($conn);
        }
    }
?>
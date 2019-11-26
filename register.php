<?php
    include 'connect.php';
    if($_SERVER['REQUEST_METHOD']=='POST')
    {
        $username=$_POST['username'];
        $password=$_POST['password'];
        $password=password_hash($password,PASSWORD_DEFAULT);
        $hoten=$_POST['hoten'];
        $ngaysinh=$_POST['ngaysinh'];
        $sdt=$_POST['sdt'];
        require_once 'connect.php';
        
        $sql="SELECT * FROM user_table WHERE username='$username'";
        $response=$conn->query($sql);
        $row=mysqli_fetch_assoc($response);
        if($row)
        {
            $result['success']='-1';
            echo json_encode($result);
            mysqli_close($conn);
        } else
        {
            $sql="INSERT INTO user_table (username,password,hoten,ngaysinh,sdt) 
            VALUES ('$username','$password','$hoten','$ngaysinh','$sdt')";

            if($conn->query($sql)===TRUE)
            {
                $result['success']='1';
                echo json_encode($result);
                mysqli_close($conn);
            } else{
                $result['success']='0';
                echo json_encode($result);
                mysqli_close($conn);
            }
        }
    }
?>
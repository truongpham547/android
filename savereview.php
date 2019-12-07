<?php
    include 'connect.php';
    require('jwt.php');
    require('header.php');
    $token=getBearerToken();
    date_default_timezone_set('Asia/Ho_Chi_Minh');
    if($_SERVER['REQUEST_METHOD']=='POST'&&$token!=null)
    {
        try{
            $auth=JWT::decode($token, "truong pham", true);
        } catch(Exception $e){}
        $sql="SELECT* FROM user_table WHERE username='$auth'";
        $response=  $response=$conn->query($sql);;
        $row=mysqli_fetch_assoc($response);
        if($row)
        {
            $username=$_POST['username'];
        $idreview=$_POST['idreview'];
        $isdel=$_POST['delete'];
        $ngayluu=date('Y-m-d H:i:s');
        require_once 'connect.php';
        
        if(isset($isdel))
        {
            $sql="DELETE FROM save_table WHERE username='$username' and idreview='$idreview'";
            if($conn->query($sql)===TRUE)
            {
                $result['success']='1';
                echo json_encode($result);
                mysqli_close($conn);
            }
            else{
                $result['success']='0';
                echo json_encode($result);
                mysqli_close($conn);
            }
        } else{
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
        }
        else{
            $result['success']='0';
            echo json_encode($result);
            mysqli_close($conn);
        }
        
    }
    else{
        $result['success']='0';
        echo json_encode($result);
    }
?>
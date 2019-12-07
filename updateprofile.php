<?php
    include 'connect.php';
    require('jwt.php');
    require('header.php');
    $token=getBearerToken();
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
            $result;
            if(isset($_POST['oldpass']))
            {
                $oldpass=$_POST['oldpass'];
                $newpass=$_POST['newpass'];
                $sql="SELECT * FROM user_table WHERE username='$username'";
                $response=$conn->query($sql);
                $row=mysqli_fetch_assoc($response);
    
                if($row && password_verify($oldpass,$row['password'])){
                    $newpass=password_hash($newpass,PASSWORD_DEFAULT);
                    $sql="UPDATE user_table set password='$newpass' where username='$username'";
                    if($conn->query($sql)===TRUE) $result['success']='1';
                    else $result['success']='0';
                        
                } else $result['success']='-1';
                   
            } else
    
            if(isset($_POST['hoten']))
            {
                $hoten=$_POST['hoten'];
                $ngaysinh=$_POST['ngaysinh'];
                $sdt=$_POST['sdt'];
                $sql="UPDATE user_table set hoten='$hoten',ngaysinh='$ngaysinh',sdt='$sdt' WHERE username='$username'";
                if($conn->query($sql)===TRUE) $result['success']='1';
                else $result['success']='0';
            } else
    
            if(isset($_POST['ava']))
            {
                $ava=$_POST['ava'];
               
                $name_ava=$username.'.jpg';
                $link='avatar/'.$name_ava;
                if(file_put_contents($link,base64_decode($ava))&&
                    $conn->query("UPDATE user_table set ava='$name_ava' where username='$username'"))
                $result['success']='1';
                else $result['success']='0';
            }
    
            echo json_encode($result);
            mysqli_close($conn);
            
        }
        else{
            $result['success']='0';
            echo json_encode($result);
            mysqli_close($conn);
        }
        
    }else{
        $result['success']='0';
        echo json_encode($result);
    }
?>
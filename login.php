<?php
    include 'connect.php';
    require('jwt.php');
    if($_SERVER['REQUEST_METHOD']=='POST')
    {
        $username=$_POST['username'];
        $password=$_POST['password'];
    
        require_once 'connect.php';

        $sql="SELECT username,password,hoten,DATE_FORMAT(ngaysinh,'%d/%m/%Y') ngaysinh,sdt,ava FROM user_table WHERE username='$username'";
        $response=$conn->query($sql);
        $row=mysqli_fetch_assoc($response);
        $result=array();
        $result['info']=array();
        if($row && password_verify($password,$row['password'])){
            $info['username']=$row['username'];
            $info['hoten']=$row['hoten'];
            $info['ngaysinh']=$row['ngaysinh'];
            $info['sdt']=$row['sdt'];
            $info['ava']=$row['ava'];
            array_push($result['info'],$info);
            $result['success']="1";
            $token = JWT::encode($username, "truong pham");
            $result['token']=$token;
        } else $result['success']="0";
        echo json_encode($result);
    }
?>
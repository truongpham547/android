<?php
    include 'connect.php';
    require('jwt.php');
    if($_SERVER['REQUEST_METHOD']=='POST')
    {
        require_once 'connect.php';
        $idreview=$_POST['idreview'];
        $username=$_POST['username'];
        $token=$_POST['token'];
        try{
            $auth=JWT::decode($token, "truong pham", true);
        } catch(Exception $e){}
        if($auth==$username)
        {
            $sql="DELETE FROM review_table WHERE id='$idreview'";
            $name_hinhanh=$idreview.'.jpg';
            $link='hinhanh/'.$name_hinhanh;
            unlink($link);
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
        }
        else{
            $result['success']='0';
            echo json_encode($result);
            mysqli_close($conn);
        }
    }
?>
<?php
    include 'connect.php';
    require('jwt.php');
    require('header.php');
    $token=getBearerToken();
    if($_SERVER['REQUEST_METHOD']=='POST'&&$token!=null)
    {
        require_once 'connect.php';
        $idreview=$_POST['idreview'];
        try{
            $auth=JWT::decode($token, "truong pham", true);
        } catch(Exception $e){}
        $sql="SELECT* FROM user_table WHERE username='$auth'";
        $response=  $response=$conn->query($sql);;
        $row=mysqli_fetch_assoc($response);
        if($row)
        {
            $sql1="DELETE FROM rate_table WHERE idreview='$idreview'";
            $conn->query($sql1);
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
    }  else{
        $result['success']='0';
        echo json_encode($result);
    }
?>
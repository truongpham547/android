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
            $noidung=$_POST['noidung'];
            $rating=$_POST['rating'];
            $hinhanh=$_POST['hinhanh'];
            $name_hinhanh=$username.$idreview.'.jpg';
            $link='hinhanh/'.$name_hinhanh;
            $ngaydang=date('Y-m-d H:i:s');
            require_once 'connect.php';
            
            $sql="SELECT * FROM rate_table WHERE username='$username' and idreview='$idreview'";
            $response=$conn->query($sql);
            $row=mysqli_fetch_assoc($response);
            
            if($row)
                $sql="UPDATE rate_table set ngaydang='$ngaydang',noidung='$noidung',rating='$rating',hinhanh='$hinhanh' where username='$username' and idreview='$idreview'";
            else
            $sql="INSERT INTO rate_table (username,idreview,ngaydang,noidung,rating,hinhanh) VALUES ('$username','$idreview','$ngaydang','$noidung','$rating','$hinhanh')";
    
            if($conn->query($sql)===TRUE&&file_put_contents($link,base64_decode($hinhanh))
            {
                $result['success']='1';
            
                $sql="SELECT rating FROM review_table WHERE id='$idreview'";
                $response=$conn->query($sql); 
                $row=mysqli_fetch_assoc($response);
                if($row)
                $result['value']=$row['rating'];
                echo json_encode($result);
                mysqli_close($conn);
            } else{
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
       
    }else{
        $result['success']='0';
        echo json_encode($result);
    }
?>
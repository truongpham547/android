<?php
    include 'connect.php';
    if($_SERVER['REQUEST_METHOD']=='POST')
    {
        $idreview=$_POST['idreview'];
        require_once 'connect.php';

        $sql="DELETE FROM review_table WHERE id='$idreview'";
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
?>
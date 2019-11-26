<?php
	include "connect.php";
	
	class rating{
		function rating($username,$hoten,$ava,$idreview,$ngaydang,$noidung,$rating)
		{
			$this->username=$username;
			$this->hoten=$hoten;
			$this->ava=$ava;
			$this->idreview=$idreview;
			$this->ngaydang=$ngaydang;
			$this->noidung=$noidung;
			$this->rating=$rating;
		}
	}
	
	if($_SERVER['REQUEST_METHOD']=='GET')
    {
        require_once 'connect.php';
        $id=$_GET['id'];
        $sql="select user_table.username,hoten,ava,rate_table.idreview,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,rate_table.noidung,rate_table.rating from rate_table INNER JOIN user_table on rate_table.username=user_table.username where idreview='$id' order by ngaydang desc";
	    $arrrating=array();
	    $data=mysqli_query($conn,$sql);

	    while ($row=mysqli_fetch_assoc($data)) {
		
	    	array_push($arrrating,new rating(
		    	$row['username'],
		    	$row['hoten'],
		    	$row['ava'],
		    	$row['idreview'],
			    $row['ngaydang'], 
			    $row['noidung'], 
			    $row['rating']));
	    }
	    echo json_encode($arrrating);
	}
	
?>
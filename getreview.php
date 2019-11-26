<?php
	include "connect.php";
	
	class review{
		function review($id,$username,$ngaydang,$tieude,$noidung,$diachi,$hinhanh,$rating)
		{
			$this->id=$id;
			$this->username=$username;
			$this->ngaydang=$ngaydang;
			$this->tieude=$tieude;
			$this->noidung=$noidung;
			$this->diachi=$diachi;
			$this->hinhanh=$hinhanh;
			$this->rating=$rating;
		}
	}
	
	if($_SERVER['REQUEST_METHOD']=='GET')
    {
		require_once 'connect.php';
		if(isset($_GET['username'])) 
		{
			$username=$_GET['username'];

			if(isset($_GET['getsave']))
				$sql="SELECT id,review_table.username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table inner join (select *from save_table WHERE username='$username') a on id=idreview order by ngayluu desc";
			else        
				$sql="SELECT id,username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table where username='$username' order by id desc";

		} else
		if(isset($_GET['search']))
		{
			$keyword=''.$_GET['search'].'';
			$sql="SELECT id,username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table where MATCH(tieude,diachi) AGAINST('$keyword')";
		} 
		else
		if(isset($_GET['trending']))
		{
			$sql="SELECT id,username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table inner join (select idreview,count(*) soluong from rate_table group by idreview) a
				on id=idreview order by soluong desc,id desc";
		} 
		else $sql="SELECT id,username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table order by id desc";
		$arrreview=array();
	    $data=$conn->query($sql);
		if($data){
			while ($row=mysqli_fetch_assoc($data)) {
		
				array_push($arrreview,new review(
					$row['id'],
					$row['username'],
					$row['ngaydang'], 
					$row['tieude'], 
					$row['noidung'], 
					$row['diachi'],
					$row['hinhanh'],
					$row['rating']));
			}
			echo json_encode($arrreview);
		}
	   
	}
	
?>
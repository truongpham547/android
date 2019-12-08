<?php
	include "connect.php";
	require('jwt.php');
    require('header.php');
    $token=getBearerToken();
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
	
	if($_SERVER['REQUEST_METHOD']=='GET'&&$token!=null)
    {
		require_once 'connect.php';
		try{
            $auth=JWT::decode($token, "truong pham", true);
        } catch(Exception $e){}
        $sql="SELECT* FROM user_table WHERE username='$auth'";
        $response=  $response=$conn->query($sql);;
        $row=mysqli_fetch_assoc($response);
        if($row)
        {
            if(isset($_GET['username'])) 
		{
			$username=$_GET['username'];
			$area=$_GET['area'];
			if($area!="TP. HCM") $area=$area.", TP. HCM";
			if(isset($_GET['getsave']))
				$sql="SELECT id,review_table.username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table inner join (select *from save_table WHERE username='$username') a on id=idreview where diachi like %'$area'% order by ngayluu desc";
			else        
				$sql="SELECT id,username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table where username='$username' and diachi like %'$area'% order by id desc";

		} else
		if(isset($_GET['search']))
		{
			$keyword=''.$_GET['search'].'';
			$sql="SELECT id,username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table where MATCH(tieude,diachi) AGAINST('$keyword') and diachi like %'$area'%";
		} 
		else
		if(isset($_GET['trending']))
		{
			$sql="SELECT id,username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table left join (select idreview,count(*) soluong from rate_table group by idreview) a
				on id=idreview where diachi like %'$area'% order by soluong desc,id desc";
		} 
		else $sql="SELECT id,username,DATE_FORMAT(ngaydang, '%d/%m/%Y') ngaydang,tieude,noidung,diachi,hinhanh,rating 
				FROM review_table where diachi like %'$area'% order by id desc";
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
        else{
            $result['success']='0';
            echo json_encode($result);
            mysqli_close($conn);
        }
	} else{
        $result['success']='0';
		echo json_encode($result);
	}
	
?>
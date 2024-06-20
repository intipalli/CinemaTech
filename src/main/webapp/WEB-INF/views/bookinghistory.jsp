<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Booking history</title>
      <style>
         .topnav {
         overflow: hidden;
         background-color: #333;
         position: relative;
         }
         .topnav a {
         float: left;
         color: #f2f2f2;
         text-align: center;
         padding: 16px 16px;
         text-decoration: none;
         font-size: 17px;
         }
         .topnav a.active {
         background-color: #333;
         color: white;
         }
      </style>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" integrity="sha512-vKMx8UnXk60zUwyUnUPM3HbQo8QfmNx7+ltw8Pm5zLusl1XIfwcxo8DbWCqMGKaWeNxWA8yrx5v3SaVpMvR3CA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   </head>
   <body style="background-color:#E7F6F2">
      <%
         response.addHeader("Pragma", "no-cache");
         response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
         response.addHeader("Cache-Control", "pre-check=0, post-check=0");
         response.setDateHeader("Expires", 0);
         %>
      <div class="topnav">
         <a class="active" >24 Frames Movies</a>
         <a href="editProfile">Edit Profile</a>
         <a onclick="logout()" class="text-white">Logout</a>
      </div>
      <div class="container">
         <br>
         <br>
         <div class="row" id="history">
         </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script>
         var userid = "${sessionScope.UserId}";
         
         
         function redirectToLogin(){
         window.location.href = "login";
         
         }
         
         
         
         
         function logout(){
         $.ajax({
         	type:"GET",
         	url:"logout",
         	data:{},
         	async:false,
         	success:function(data){
         		toastr.options.closeButton = true;
                    toastr.options.positionClass = 'toast-top-center';
                    toastr.success('You are logged out. Redirecting to login page', ' Success');
                    setTimeout(redirectToLogin, 5000);
         	}
         });
         }
         
         getBookings();
         function getBookings(){
         $.ajax({
         	type:"GET",
         	url:"bookings",
         	data:{
         		uid:userid
         	},
         	async:false,
         	success:function(data){
         		if(data != null){
         			var res = $.parseJSON(data);
         			//alert(data);
         			for(var i=0;i<res.length;i++){
         				$("#history").append('<div class="col col-md-4 col-sm-12"><div class="card" style="width: 21rem;">'+
         				  '<div class="card-header"><h5>Booking Id: ' + res[i].id + '</h5></div> <div class="card-body">'+
         				    '<h6 class="card-title">Movie: ' + res[i].mn + '</h6><br>' + 
         				    '<h6 class="card-subtitle mb-2 text-muted">Date: ' + res[i].sd + '</h6><br>' + 
         				    '<h6 class="card-subtitle mb-2 text-muted">Time: ' + res[i].st + '</h6><br>' + 
         					'<h6 class="card-subtitle mb-2 text-muted">Screen Number: ' + res[i].screen + '</h6><br>' + 
         						'<h6 class="card-subtitle mb-2 text-muted">Seats: ' + res[i].seats + '</h6><br>' + 
         						'<h6 class="card-subtitle mb-2 text-muted">Price: ' + res[i].price + '$</h6><br></div></div></div>');	
         			}
         			}
         			}
         	});
         
         }
         
         
         
      </script>
   </body>
</html>
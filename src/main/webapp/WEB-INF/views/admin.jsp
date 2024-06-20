<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>admin page</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" integrity="sha512-vKMx8UnXk60zUwyUnUPM3HbQo8QfmNx7+ltw8Pm5zLusl1XIfwcxo8DbWCqMGKaWeNxWA8yrx5v3SaVpMvR3CA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   </head>
   <style>
      h1 {text-align: center;}
      .card {
      width: 60%;
      margin-top: 5%;
      border: 3px whitesmoke;
      padding: 10px 10px;
      margin: 40px;
      }
      .card-deck {
      margin-left: 33%;
      margin-right: 10%;
      }
      .card-header {
      background-color: skyblue;
      }
      .card-body {
      background: ccc;
      margin-top: 1%;
      margin-bottom: 0%;
      padding: 10px 20px
      }
      a {
      color: black;
      }
      a:hover {
      color: black;
      }
      .button {
      border: none;
      color: white;
      padding: 16px 32px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 16px;
      margin: 4px 2px;
      transition-duration: 0.4s;
      cursor: pointer;
      }
      .button1 {
      background-color: white; 
      color: black; 
      border: 2px solid #4CAF50;
      }
      .button1:hover {
      background-color: #4CAF50;
      color: white;
      }
      .button2 {
      background-color: white; 
      color: black; 
      border: 2px solid #008CBA;
      }
      .button2:hover {
      background-color: #008CBA;
      color: white;
      }
      .topnav {
      overflow: hidden;
      background-color: #333;
      position: relative;
      }
      .topnav a {
      float: left;
      color: #f2f2f2;
      text-align: center;
      padding: 20px 16px;
      text-decoration: none;
      font-size: 17px;
      }
      .topnav a.active {
      background-color: #333;
      color: white;
      }
   </style>
   <body>
      <%
         response.addHeader("Pragma", "no-cache");
         response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
         response.addHeader("Cache-Control", "pre-check=0, post-check=0");
         response.setDateHeader("Expires", 0);
         %>
      <body style="background-color:grey;">
         <div class="topnav">
            <a class="active" >24 Frames Movies</a>
            <a href="editProfile">Edit Profile</a>
            <a onclick="logout()" class="text-white">Logout</a>
         </div>
         <div class="card-deck">
            <div class="card">
               <div class="card-body text-black">
                  <h2 class="card-title" font>Manage Movies</h2>
                  <p class="card-text">This component enables the management of all movies in the system.</p>
                  <button class="button btn btn-success button1" onclick="addMovie()">Add movie</button>
                  <br>
                  <button class="button btn btn-success button2" onclick="scheduleMovie()">Schedule movie</button>
               </div>
            </div>
            <div class="card">
               <div class="card-body">
                  <h2 class="card-title">
                  Manage Promotions</h5>
                  <p class="card-text">This component enables the management of promotions in the system.</p>
                  <button class="button btn btn-success button2" onclick="addPromoPage()">Add promotion</button>
                  <br>
                  <button class="button btn btn-success button2" onclick="promotions()">Edit/Send Promotions</button>
               </div>
            </div>
            <div class="card">
               <div class="card-body">
                  <h2 class="card-title">
                  Manage Users</h5>
                  <p class="card-text">This component enables the management of users in the system.</p>
                  <button class="button btn btn-success button2" onclick="users()">Manage Users</button>
               </div>
            </div>
         </div>
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
         <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
         <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.5.2/bootbox.min.js" integrity="sha512-RdSPYh1WA6BF0RhpisYJVYkOyTzK4HwofJ3Q7ivt/jkpW6Vc8AurL1R+4AUcvn9IwEKAPm/fk7qFZW3OuiUDeg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
         <script>
            function addPromoPage(){
            	window.location.href = "addpromotion";
            
            }
            
            function addMovie(){
            	window.location.href = "addMovie";
            
            }
            
            function scheduleMovie(){
            	window.location.href = "scheduleMovie";
            
            }
            
            function promotions(){
            	window.location.href = "promotions";
            
            }
            
            function users(){
            	window.location.href = "users";
            
            }
            
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
            	})
            }
         </script>
   </body>
</html>
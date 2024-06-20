<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Book Tickets</title>
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
         th, td {
         padding-top: 30px !important;
         padding-bottom: 30px !important;
         }
      </style>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" integrity="sha512-vKMx8UnXk60zUwyUnUPM3HbQo8QfmNx7+ltw8Pm5zLusl1XIfwcxo8DbWCqMGKaWeNxWA8yrx5v3SaVpMvR3CA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   </head>
   <body>
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
      <div class="container py-5">
         <div class="card">
            <div class="card-header">
               <h2 class="text-primary" id="moviename"></h2>
            </div>
            <div class="card-body">
               <div class="row">
                  <div class="btn-group btn-group-md text-center" role="group" aria-label="Basic example" id="dateGrp">
                     <!--   <button type="button" class="btn btn-secondary">Oct 25</button>
                        -->  
                  </div>
               </div>
               <div class="row py-4">
                  <table class="table table-lg table-hover" id="shows">
                     <thead>
                        <tr>
                           <th>Screen Number</th>
                           <th>Show Times</th>
                        </tr>
                     </thead>
                     <tbody id="tbody">
                        <!--  <tr>
                           <td>1</td>
                           <td>
                               <btn class='btn btn-sm btn-outline-success'>07:00 AM</btn>&nbsp;&nbsp;
                           </td>
                           </tr> -->
                     </tbody>
                  </table>
               </div>
            </div>
         </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script>
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
         
         var dates = '${dates}';
         var res = $.parseJSON(dates);
         $("#moviename").text(res.name);
         var arr = res.dates;
         $("#dateGrp").html("");
         for(var i=0;i<arr.length;i++){
         	$("#dateGrp").append("<button type='button' class='btn btn-secondary' onclick='fill(this)'>" + arr[i] + "</button>");
         }
         
         function fill(p){
         	var date = p.innerHTML;
         	var mid = res.mid;
         	$.ajax({
         		type:"GET",
         		url:"shows",
         		data:{
         			movieid:mid,
         			showdate:date
         		},
         		async:false,
         		success:function(data){
         			if(data != null){
         				var response = $.parseJSON(data);
         				
         				$("#tbody").html("");
         				var screen = 0;
         				var tableBody = "";
         				for(var i=0;i<response.length;i++){
         					if(response[i].screen != screen){
         					screen = response[i].screen;
         					tableBody += "<tr><td>" + response[i].screen + "</td><td><button class='btn btn-sm btn-outline-secondary' name='" + date + "' onclick='seats(this)'>" +  response[i].time + "</button>&nbsp;&nbsp";
         					for(var j=i+1;j<response.length;j++){
         						if(response[j].screen == screen){
         							tableBody += "<button class='btn btn-sm btn-outline-secondary' name='" + date + "' onclick='seats(this)'>" + response[j].time + "</button>&nbsp;&nbsp";
         						}
         					}
         					tableBody += "</td></tr>";
         					}
         			        
         				}
         				$("#tbody").html(tableBody);
         			}
         		}
         	})
         }
         
         function seats(t){
         	var mid = res.mid;
         	var mname = res.name;
         	var showdate = t.getAttribute("name");
         	var showtime = t.innerHTML;
         	var screen = t.parentElement.parentElement.children[0].innerHTML;
         	window.location.href = "seats?mid=" + mid + "&" + "mname=" + mname + "&" + "showdate=" + showdate + "&" + "showtime=" + showtime + "&" + "screen=" + screen;
         
         	
         	
         }
         
      </script>
   </body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Users</title>
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
      <link rel="stylesheet" href="https://cdn.datatables.net/1.11.4/css/dataTables.bootstrap4.min.css">
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
      <div class="jumbotron jumbotron-fluid">
         <div class="container py-5">
            <h1 class="display-4 text-primary">Users</h1>
            <table class="table table-striped" id="uTable" style="width:100%;">
               <thead>
                  <tr>
                     <th scope="col">User Id</th>
                     <th scope="col">First Name</th>
                     <th scope="col">Last Name</th>
                     <th scope="col">Email address</th>
                     <th scope="col">User Status</th>
                     <th scope="col">Actions</th>
                  </tr>
               </thead>
               <tbody id="users">
               </tbody>
            </table>
         </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
      <script src="https://cdn.datatables.net/1.11.4/js/dataTables.bootstrap4.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script>
         var etable = null;
         function updateDataTable() {
           etable = $('#uTable').DataTable({
             "lengthMenu": [
               [10, 25, 50, -1],
               [10, 25, 50, "All"]
             ],
             "pageLength": -1,
         /*         "order": [[ 3, "desc" ]]
         */
           });
         }
         
         getUsers();
         updateDataTable();
         
         function redirectToLogin(){
         	window.location.href = "login";
         
         }
         
         function getUsers(){
         	$.ajax({
         		type:"GET",
         		url:"getUsers",
         		data:{},
         		async:false,
         		success:function(data){
         			if(data != null){
         				var res = $.parseJSON(data);
         				var tbody = "";
         				for(var i=0;i<res.length;i++){
         					tbody += "<tr><td>" + res[i].uid + "</td><td>" + res[i].firstname + "</td><td>" + res[i].lastname + "</td><td>" + res[i].email + "</td>";   
         					if(res[i].status == 0){
         						tbody += "<td>Inactive user</td><td>NA</td></tr>";
         					}
         					else if(res[i].status == 1){
         						tbody += "<td>Active user</td><td><button class='btn btn-sm btn-danger' onclick='suspend(this)'>suspend</button></td></tr>";
         					}
         					else{
         						tbody += "<td>Suspended user</td><td><button class='btn btn-sm btn-secondary' onclick='unsuspend(this)'>unsuspend</button></td></tr>";
         
         					}
         				
         				}
         				console.log(tbody);
         				$("#users").html(tbody);
         			}
         		}
         	});	
         }
         
         function suspend(pointer){
         	var userid = pointer.parentElement.parentElement.children[0].innerHTML;
         	var email = pointer.parentElement.parentElement.children[3].innerHTML;
         	var fn = pointer.parentElement.parentElement.children[1].innerHTML;
         	var ln = pointer.parentElement.parentElement.children[2].innerHTML;
         	var uname = fn + " " + ln;
         
         	$.ajax({
         		type:"POST",
         		url:"suspendUser",
         		data:{
         			uid:userid,
         			e:email,
         			name:uname
         		},
         		async:false,
         		success:function(data){
         			if(data != null){
         				var res = $.parseJSON(data);
         				if(res.hasOwnProperty("Success")){
         					toastr.options.closeButton = true;
         		            toastr.options.positionClass = 'toast-top-center';
         		            toastr.success(res.Success, 'Success');
         		            etable.destroy();
         		            getUsers();
         		            updateDataTable();
         				}
         			}
         		}
         	});
         }
         
         function unsuspend(pointer){
         	var userid = pointer.parentElement.parentElement.children[0].innerHTML;
         	var email = pointer.parentElement.parentElement.children[3].innerHTML;
         	var fn = pointer.parentElement.parentElement.children[1].innerHTML;
         	var ln = pointer.parentElement.parentElement.children[2].innerHTML;
         	var uname = fn + " " + ln;
         	$.ajax({
         		type:"POST",
         		url:"unsuspendUser",
         		data:{
         			uid:userid,
         			e:email,
         			name:uname
         		},
         		async:false,
         		success:function(data){
         			if(data != null){
         				var res = $.parseJSON(data);
         				if(res.hasOwnProperty("Success")){
         					toastr.options.closeButton = true;
         		            toastr.options.positionClass = 'toast-top-center';
         		            toastr.success(res.Success, 'Success');
         		            etable.destroy();
         		            getUsers();
         		            updateDataTable();
         		            }
         			}
         		}
         	});
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
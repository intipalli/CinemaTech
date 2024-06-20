<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Promotions</title>
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
            <h1 class="display-4 text-primary">Promotions</h1>
            <table class="table table-striped" id="pTable" style="width:100%;">
               <thead>
                  <tr>
                     <th scope="col">Promotion Id</th>
                     <th scope="col">Promotion Code</th>
                     <th scope="col">Discount in percentage</th>
                     <th scope="col">Start date</th>
                     <th scope="col">End date</th>
                     <th scope="col">Actions</th>
                  </tr>
               </thead>
               <tbody id="promos">
               </tbody>
            </table>
         </div>
      </div>
      <div class="modal fade" id="editP" tabindex="-1" role="dialog" aria-labelledby="codeModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="codeModalTitle">Edit Promotion</h5>
               </div>
               <div class="modal-body">
                  <div class="row">
                     <div class="col">
                        <label for="promocode">Promotion code</label>
                        <input type="text" id="promocode" placeholder="Enter promo code" class="form-control" /><br>
                        <label for="discountvalue">Discount</label>
                        <input type="text" id="discountvalue" placeholder="Enter discount value" 
                           class="form-control" /><br>
                        <label for="startdate">Start Date</label>
                        <input type="date" id="startdate" placeholder="Select Start Date" class="form-control" /><br>
                        <label for="enddate">End Date</label>
                        <input type="date" id="enddate" placeholder="Select End date" class="form-control" /><br>
                     </div>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="button" onclick="editPromotion()" class="btn btn-success">Edit</button>
               </div>
            </div>
         </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script>
         getPromos();
         
         function redirectToLogin(){
         	window.location.href = "login";
         
         }
         
         function getPromos(){
         	$.ajax({
         		type:"GET",
         		url:"getPromos",
         		data:{},
         		async:false,
         		success:function(data){
         			if(data != null){
         				var res = $.parseJSON(data);
         				var tbody = "";
         				for(var i=0;i<res.length;i++){
         					tbody += "<tr><td>" + res[i].pid + "</td><td>" + res[i].pcode + "</td><td>" + res[i].discount + "</td><td>" + res[i].sd + "</td><td>" + res[i].ed + "</td><td>" + (res[i].sent == 0 ? "<button class='btn btn-sm btn-secondary' onclick='editPromo(this)'>Edit</button>&nbsp;&nbsp;<button class='btn btn-sm btn-success' onclick='sendPromotion(" + res[i].pid + ")'>send</button>":"Promotion Sent") + "</td></tr>";
         				}
         				console.log(tbody);
         				$("#promos").html(tbody);
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
         var promoid=0;
         function editPromo(pointer){
         	promoid = pointer.parentElement.parentElement.children[0].innerHTML;
         	var promocode = pointer.parentElement.parentElement.children[1].innerHTML;
         	var discount = pointer.parentElement.parentElement.children[2].innerHTML;
         	var sd = pointer.parentElement.parentElement.children[3].innerHTML;
         	var ed = pointer.parentElement.parentElement.children[4].innerHTML;
         
         	$("#editP").modal("show");
         	$("#promocode").val(promocode);
         	$("#discountvalue").val(discount);
         	$("#startdate").val(sd);
         	$("#enddate").val(ed);
         
         }
         
         function editPromotion(){
         	var pc = $("#promocode").val();
         	var discount = $("#discountvalue").val();
         	var sd = $("#startdate").val();
         	var ed = $("#enddate").val();
         	if(pc != "" && discount != "" && sd != "" && ed != ""){
         		
         		$.ajax({
         			type:"POST",
         			url:"editPromotion",
         			data:{
         				pid:promoid,
         				promocode:pc,
         				dis:discount,
         				startdate:sd,
         				enddate:ed
         			},
         			async:false,
         			success:function(data){
         				if(data != null){
         					var res = $.parseJSON(data);
         					if(res.hasOwnProperty("Success")){
         						toastr.options.closeButton = true;
         			            toastr.options.positionClass = 'toast-top-center';
         			            toastr.success(res.Success, 'Success');
         						$("#editP").modal("hide");
         
         			            getPromos();
         
         					}
         					
         
         				}
         			}
         		});
         	}
         	else{
         		toastr.options.closeButton = true;
                 toastr.options.positionClass = 'toast-top-center';
                 toastr.warning('Please provide all details', 'Warning');
         	}
         
         }
         
         function sendPromotion(pid){
         	
         	$.ajax({
         		type:"POST",
         		url:"sendPromotion",
         		data:{
         			promoid:pid	
         		},
         		async:false,
         		success:function(data){
         			if(data != null){
         				var res = $.parseJSON(data);
         				if(res.hasOwnProperty("Success")){
         					toastr.options.closeButton = true;
         		            toastr.options.positionClass = 'toast-top-center';
         		            toastr.success(res.Success, 'Success');
         		            getPromos();
         
         				}
         			}
         		}
         		
         	});
         }
         
      </script>
   </body>
</html>
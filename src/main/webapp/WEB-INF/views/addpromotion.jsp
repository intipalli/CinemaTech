<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Add Promotion</title>
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
      <div class="container py-5">
         <div class="row">
            <div class="col-lg-7 mx-auto">
               <div class="bg-white rounded-lg shadow-lg rounded-3 p-5">
                  <div class="tab-content">
                     <div id="nav-tab-card" class="tab-pane fade show active">
                        <h3 class="display-4 text-center">Add Promotion</h3>
                        <br>
                        <div class="mb-3">
                           <label for="promocode" class="h5"><span>*</span> Promotion code</label>
                           <input type="text" id="promocode" placeholder="Enter promo code" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="discountvalue" class="h5"><span>*</span> Discount(%)</label>
                           <input type="text" id="discountvalue" placeholder="Enter discount value" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="startdate" class="h5"><span>*</span> Start Date</label>
                           <input type="date" id="startdate" placeholder="Select Start Date" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="enddate" class="h5"><span>*</span> End Date</label>
                           <input type="date" id="enddate" placeholder="Select End date" 
                              class="form-control" />
                        </div>
                        <br>
                        <div>
                           <button class="btn btn-success btn-login fw-bold" type="button" onclick="addPromotion()">Save
                           </button>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script>
         function redirectToPromotions(){
         	window.location.href = "promotions";
         
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
         
         function addPromotion(){
         	var pc = $("#promocode").val();
         	var discount = $("#discountvalue").val();
         	var sd = $("#startdate").val();
         	var ed = $("#enddate").val();
         	if(pc != "" && discount != "" && sd != "" && ed != ""){
         		
         		$.ajax({
         			type:"POST",
         			url:"addPromotion",
         			data:{
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
         			            toastr.success(res.Success + ' Redirecting to promotions page', 'Success');
         			            setTimeout(redirectToPromotions, 3000);
         
         					}
         					else{
         						
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
         
      </script>
   </body>
</html>
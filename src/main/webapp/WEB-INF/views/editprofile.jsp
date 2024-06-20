<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Edit Profile</title>
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
      </div>
      <div class="container py-5">
         <div class="row">
            <div class="col-lg-7 mx-auto">
               <div class="bg-white rounded-lg shadow-lg rounded-3 p-5">
                  <div class="tab-content">
                     <div id="nav-tab-card" class="tab-pane fade show active">
                        <h3 class="display-4 text-center text-secondary">Edit Profile</h3>
                        <br>
                        <div class="mb-3">
                           <label for="fn" class="h5"><span class="text-danger">*</span> First Name</label>
                           <input type="text" id="fn" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="ln" class="h5"><span class="text-danger">*</span> Last Name</label>
                           <input type="text" id="ln" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="email" class="h5"><span class="text-danger">*</span> Email Address</label>
                           <input type="email" id="email" 
                              class="form-control" disabled/>
                        </div>
                        <div class="mb-3">
                           <label for="add" class="h5"><span class="text-danger">*</span> Address</label>
                           <input type="text" id="add" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="cards" class="h5"><span>*</span> Choose Card Type</label>
                           <select name="cards" id="card">
                              <option value="1">Credit Card</option>
                              <option value="2">Debit Card</option>
                           </select>
                        </div>
                        <div class="mb-3">
                           <label for="cno" class="h5"><span class="text-danger">*</span> Card Number</label>
                           <input type="text" id="cno" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="em" class="h5"><span class="text-danger">*</span> Expiry month</label>
                           <input type="text" id="em" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="ey" class="h5"><span class="text-danger">*</span> Expiry year</label>
                           <input type="text" id="ey" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="cvv" class="h5"><span class="text-danger">*</span> CVV</label>
                           <input type="text" id="cvv" 
                              class="form-control" />
                        </div>
                        <input type="checkbox" id="promos" name="promos" value=""> Receive promotions<br>
                        <a href="#" class="text-primary" onclick="showPasswordModal()">Change Password</a><br>
                        <br>
                        <div class="d-grid">
                           <button class="btn btn-success btn-login fw-bold" onclick="editProfile()" type="button">Edit
                           </button>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="changePassword" tabindex="-1" role="dialog" aria-labelledby="codeModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="codeModalTitle">Change Password</h5>
               </div>
               <div class="modal-body">
                  <div class="row" id="fpCode">
                     <div class="col">
                        <input type="password" id="cp" placeholder="Your current password" style="width:100%;" ><br><br>
                        <input type="password" id="np" placeholder="Your new password" style="width:100%;" ><br><br>
                        <input type="password" id="rp" placeholder="re-enter password" style="width:100%;" ><br><br>
                     </div>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="button" id="cpsubmit" class="btn btn-success">Submit</button>
               </div>
            </div>
         </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.5.2/bootbox.min.js" integrity="sha512-RdSPYh1WA6BF0RhpisYJVYkOyTzK4HwofJ3Q7ivt/jkpW6Vc8AurL1R+4AUcvn9IwEKAPm/fk7qFZW3OuiUDeg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script>
         function show(a){
         	toastr.options.closeButton = true;
         	toastr.options.positionClass = 'toast-top-center';
         	toastr.warning(a, ' warning');
         }
         function showPasswordModal() {
             $('#cp').val('');
            $('#np').val('');
            $('#rp').val('');
         
            $('#changePassword').modal('show');
            $("#em").text("");
          }
         function redirectToLogin(){
         	window.location.href = "login";
         
         }
          fillData();
          function fillData(){
         	 var userId = "${sessionScope.UserId}";
         	 userId = parseInt(userId);
         	 $.ajax({
         		 type:"GET",
         		 url:"getUserData",
         		 data:{
         			uid:userId 
         		 },
         		 async:false,
         		 success:function(data){
         			 if(data != null){
         				 //alert(data);
         			 var response = $.parseJSON(data);
         			 	$("#fn").val(response.firstname);
         			 	$("#ln").val(response.lastname);
         			 	$("#email").val(response.email);
         			 	$("#add").val(response.address);
         			 	$("#card").val((response.cardtype).toString());
         			 	$("#cno").val(response.cardno);
         			 	$("#em").val(response.expm);
         			 	$("#ey").val(response.expy);
         			 	$("#cvv").val(response.cvv);
         			 	if(response.subscribed == 1){
         			 		document.getElementById("promos").checked = true;
         			 	}
         
         			 }
         			 
         		 }
         	 });
          }
          
          function editProfile() {
         	 var firstname = $("#fn").val();
              var lastname = $("#ln").val();
              var email = $("#email").val();
              var add = $("#add").val();
              var ctype = $("#card").val();
              var cno = $("#cno").val();
              var em = $("#em").val();
              var ey = $("#ey").val();
              var cvv = $("#cvv").val();
              var check;
              const cb = document.querySelector('#promos');
         	if(cb.checked){
         		check=1;
         	}
         	else{
         		check=0;
         	}
              
         
              if(firstname != '' && lastname != '' && email != '' && add != '' &&
             		 ctype != '' && cno != '' && cvv != '' && em != '' && ey != ''){
             	
             	  if(ey.length < 4 || ey.length > 4 || parseInt(ey) < 2022){
             		 show('length of expiry year must be 4 and value should be greater than current year');
             		 return;
             		 
             	 }
             	 else if(em.length > 2 || parseInt(em) > 12 || parseInt(em) < 1 )
             		 {
             		 show("length of expiry month should not be greater than 2 and value should be less than 12 and greater than 1");
             		 return;
             		 }
             	 else if(cvv.length > 3 || cvv.length < 3){
             		 show("length of cvv should be 3 digits");
             		 return;
             	 }
             	 else if(cno.length > 16 || cno.length < 16){
             		 show("length of card number should be 16 digits");
             		 return;
             	 }
             	
                  $.ajax({
                      type: "POST",
                      url: "editProfile",
                      data: {
                     	 emailid:email,
                        firstName: firstname,
                        lastName: lastname,
                        cardtype:ctype,
                        cardno:cno,
                        cardcvv:cvv,
                        expm:em,
                        expy:ey,
                        billinga:add,
                        checkbox:check
                      },
                      async: false,
                      success: function(data) {
                        if (data != null) {
                            var response = $.parseJSON(data);
                            if (response.hasOwnProperty("Warning")) {
                           	 toastr.options.closeButton = true;
                                toastr.options.positionClass = 'toast-top-center';
                                toastr.warning(response.Warning, 'Warning');
           					} 
                          if (response.hasOwnProperty("Success")) {
                         	 toastr.options.closeButton = true;
                              toastr.options.positionClass = 'toast-top-center';
                              toastr.success('User edited Successfully', ' Success');
                              fillData();
         					
         					} 
                        } 
                      }
                    });
             	 
              }
              else {
                  if (firstname == '') {
                 	 show('Please enter first name');
                 }
                  else if (lastname == '') {
                 	 show('Please enter last name');
         
                  }
                  
                  else if (email == '') {
                 	 show('Please enter email');
         
                  }
                 
                  else if (ctype == '') {
                 	 show('Please choose card type');
         
                  }
                  else if (cno == '') {
                 	 show('Please enter card number');
         
                    }
                  else if (cvv == '') {
                 	 show('Please enter cvv');
         
                    }
                  else if (em == '') {
                 	 show('Please enter expiry month');
         
                    }
                  else if (ey == '') {
                 	 show('Please enter expiry year');
         
                    }
                  else if (add == '') {
                 	 show('Please enter billing address');
         
                    }
                }
         
         
              
         }
          
          $("#cpsubmit").click(function(){
         	 
         	 var cp = $("#cp").val();
         	 var np = $("#np").val();
         	 var rp = $("#rp").val();
         	 if(cp != '' && np != '' && rp != ''){
         		 let pattern1 = /[a-z]/;
                  let pattern2 = /[A-Z]/;
                  let pattern3 = /[0-9]/;
                  let pattern4 = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
                  
                  
                  
                  if (!(pattern1.test(np) && pattern2.test(np) && pattern3.test(np) && pattern4.test(np))) {
                  show('Password must have atleast one lowercase letter, uppercase letter, number and special character');
                    return;
                  }
         		 if(np != rp){
         			 toastr.options.closeButton = true;
         			toastr.options.positionClass = 'toast-top-center';
         			toastr.warning("Password did not match", 'warning');
         			 return;
         		 }
         		 else{
         			 
         	 $.ajax({
         		type:"POST",
         		url:"changePassword",
         		data:{
         			cp:cp,
         			np:np
         			},
         		async:false,
         		success:function(data){
         			if(data != null){
         			var response = $.parseJSON(data);
         			if(response.hasOwnProperty("Error")){
         				toastr.options.closeButton = true;
         				toastr.options.positionClass = 'toast-top-center';
         				toastr.error(response.Error, 'Error');
         			}
         			else{
         				toastr.options.closeButton = true;
         				toastr.options.positionClass = 'toast-top-center';
         				toastr.success(response.Success, 'Success');
         				$("#changePassword").modal("hide");
                         setTimeout(redirectToLogin, 5000);
         
         			}
         			
         		}
         		}
         	 });
         		 
         	 }
         	 }
         	 else{
         		  toastr.options.closeButton = true;
         			toastr.options.positionClass = 'toast-top-center';
         			toastr.warning("Please enter all values", ' warning');
         
         		}
          });
          
      </script>
   </body>
</html>
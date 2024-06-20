<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Register</title>
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
      <title>Admin Main</title>
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
                        <h3 class="display-4 text-center">Register</h3>
                        <br>
                        <p class="h6"><span>*</span> indicates required fields</p>
                        <div class="mb-3">
                           <label for="fn" class="h5"><span>*</span> First Name</label>
                           <input type="text" id="fn" placeholder="Enter First Name" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="ln" class="h5"><span>*</span> Last Name</label>
                           <input type="text" id="ln" placeholder="Enter Last Name" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="username" class="h5"><span>*</span> Enter Username</label>
                           <input type="text" id="uname" placeholder="Enter Username"
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="email" class="h5"><span>*</span> Enter Email</label>
                           <input type="email" id="email" placeholder="Enter Email" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="email" class="h5"><span>*</span> Enter Mobile Number</label>
                           <input type="text" id="mobile" placeholder="Enter mobile number" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="age" class="h5"><span>*</span> Enter Age</label>
                           <input type="text" id="age" placeholder="Enter age" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="pwd" class="h5"><span>*</span> Enter Password</label>
                           <input type="password" id="pwd" placeholder="Enter Password"
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="pwd" class="h5"><span>*</span> Confirm Password</label>
                           <input type="password" id="cpwd" placeholder="Confirm Password" 
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
                           <label for="pwd" class="h5"><span>*</span> card number</label>
                           <input type="text" id="cardno" placeholder="Enter Card number" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="pwd" class="h5"><span>*</span> CVV</label>
                           <input type="text" id="cvv" placeholder="Enter CVV" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="pwd" class="h5"><span>*</span >Expiry Month</label>
                           <input type="text" id="expmonth" placeholder="Expiration Month" 
                              class="form-control" />
                           <label for="expyear" class="h5"><span>*</span> Expiry Year</label>
                           <input type="text" id="expyear" placeholder="Expiry Year"
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="billingadd" class="h5"><span>*</span> Billing Address</label>
                           <input type="text" id="billingadd" placeholder="Enter Address Information" 
                              class="form-control" />
                        </div>
                        <input type="checkbox" id="promos" name="promos" value=""> Receive promotions<br>
                        <div>
                           <button class="btn btn-success btn-login fw-bold" type="button" onclick="register()">Register
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
         function show(a){
         	toastr.options.closeButton = true;
         	toastr.options.positionClass = 'toast-top-center';
         	toastr.warning(a, ' warning');
         }
         
         function redirectToLogin(){
         	window.location.href = "login";
         
         }
         
         
         function register() {
         	 var firstname = $("#fn").val();
              var lastname = $("#ln").val();
              var uname = $("#uname").val();
              var email = $("#email").val();
              var mobile = $("#mobile").val();
              var password = $("#pwd").val();
              var confirmpassword = $("#cpwd").val();
              var ctype = $("#card").val();
              var cno = $("#cardno").val();
              var cvv = $("#cvv").val();
              var em = $("#expmonth").val();
              var ey = $("#expyear").val();
              var ba = $("#billingadd").val();
              var age = $("#age").val();
         
              var check;
              const cb = document.querySelector('#promos');
         	if(cb.checked){
         		check=1;
         	}
         	else{
         		check=0;
         	}
              
         
              if(firstname != '' && lastname != '' && uname != '' && email != '' && mobile != '' && password != '' && confirmpassword != '' &&
             		 ctype != '' && cno != '' && cvv != '' && em != '' && ey != '' && ba != '' && age != ''){
             	
             	 let pattern1 = /[a-z]/;
                  let pattern2 = /[A-Z]/;
                  let pattern3 = /[0-9]/;
                  let pattern4 = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
                  
                  
                  
                  if (!(pattern1.test(password) && pattern2.test(password) && pattern3.test(password) && pattern4.test(password))) {
                  show('Password must have atleast one lowercase letter, uppercase letter, number and special character');
                    return;
                  }
                  
                  else if(mobile.length > 10){
                 	 show('Mobile number is greater than 10 digits');
                 	 return;
         
             	 }
             	 else if(email.includes("@gmail.com") == false){
             		 show('Email must contain @gmail.com');
                 	 return;
             	 }
             	 else if(password != confirmpassword){
             		 show('Passwords does not match');
                 	 return;
             	 }
             	 else if(ey.length < 4 || ey.length > 4 || parseInt(ey) < 2022){
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
                      url: "register",
                      data: {
                        firstName: firstname,
                        lastName: lastname,
                        username: uname,
                        EmailAdd:email,
                        Mobile: mobile,
                        age:age,
                        Password: password,
                        cpassword:confirmpassword,
                        cardtype:ctype,
                        cardno:cno,
                        cardcvv:cvv,
                        expm:em,
                        expy:ey,
                        billinga:ba,
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
                              toastr.success('User Registered Successfully', ' Success');
                              setTimeout(redirectToLogin, 5000);
         
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
                  else if (uname == '') {
                 	 show('Please enter username');
                  }
                  else if (email == '') {
                 	 show('Please enter email');
         
                  }
                  else if (mobile == '') {
                 	 show('Please enter mobile');
                  }
                  else if (password == '') {
                 	 show('Please enter password');
         
                  }
                  else if (confirmpassword == '') {
                 	 show('Please re-enter password');
         
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
                  else if (ba == '') {
                 	 show('Please enter billing address');
         
                  }
                }
         
         
              
         }
      </script>
   </body>
</html>
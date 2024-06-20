<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Login</title>
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
                        <form action="login" method="post" onsubmit="return remember()">
                           <h3 class="display-4 text-center text-secondary"><b>Login</b></h3>
                           <br>
                           <div class="mb-3">
                              <label for="fn" class="h5"><span class="text-danger">*</span> Username</label>
                              <input type="text" id="fn" placeholder="Enter Username" required="true"
                                 class="form-control" name="uname"/>
                           </div>
                           <div class="mb-3">
                              <label for="ln" class="h5"><span class="text-danger">*</span> Password</label>
                              <input type="password" id="ln" placeholder="Enter Password" required="true"
                                 class="form-control" name="upassword"/>
                           </div>
                           <div class="mb-3">
                              <a href="#" class="text-primary" onclick="showUsernameModal()">Forgot Password</a><br>
                              <a href="registerPage" class="text-primary">Register</a>
                              <a href="home" style="float:right">Guest user</a><br>
                              <input type="checkbox" id="remme" value="">Remember me
                           </div>
                           <div class="d-grid">
                              <button class="btn btn-success btn-login fw-bold" type="submit">Login
                              </button>
                           </div>
                        </form>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="usernameModal" tabindex="-1" role="dialog" aria-labelledby="usernameModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="usernameModalTitle">User Verification</h5>
               </div>
               <div class="modal-body">
                  <div class="row" id="fpUsername">
                     <div class="col">
                        <input type="text" id="forgotPasswordUsername" placeholder="Enter your username" style="width:100%;" required>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <p class="text-danger" id="usernameModalErrorMessage"></p>
                     </div>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="button" id="usernameModalSubmitButton" class="btn btn-success">Submit</button>
               </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="codeModal" tabindex="-1" role="dialog" aria-labelledby="codeModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="codeModalTitle">User Validation</h5>
               </div>
               <div class="modal-body">
                  <div class="row" id="fpCode">
                     <div class="col">
                        <label for="code">An OTP has been sent to your email address, please enter it.</label>
                        <input type="text" id="code" placeholder="Your verification code" style="width:100%;" required>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <p class="text-danger" id="codeModalErrorMessage"></p>
                     </div>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="button" id="codeModalSubmitButton" class="btn btn-success">Submit</button>
               </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="newP" tabindex="-1" role="dialog" aria-labelledby="codeModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h5 class="modal-title" id="codeModalTitle">Password reset</h5>
               </div>
               <div class="modal-body">
                  <div class="row" id="fpCode">
                     <div class="col">
                        <label for="np">Enter new password</label>
                        <input type="password" id="np" placeholder="Your new password" style="width:100%;" required><br>
                        <label for="cp">Confirm password</label>
                        <input type="password" id="cp" placeholder="re-enter password" style="width:100%;" required>
                     </div>
                  </div>
                  <div class="row">
                     <div class="col">
                        <p class="text-danger" id="npem"></p>
                     </div>
                  </div>
               </div>
               <div class="modal-footer">
                  <button type="button" id="npsubmit" class="btn btn-success">Submit</button>
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
         setData();
         function setData(){
         $("#fn").val(getCookie("username"));
         $("#ln").val(getCookie("password"));
         //alert(getCookie("password"));
         
         }
         function getCookie(cname) {
          let name = cname + "=";
          let decodedCookie = decodeURIComponent(document.cookie);
          let ca = decodedCookie.split(';');
          for(let i = 0; i <ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') {
              c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
              return c.substring(name.length, c.length);
            }
          }
          return "";
         }
         
         function remember(){
         if(document.getElementById("remme").checked){
          var un = $("#fn").val();
          var pass = $("#ln").val();
          document.cookie = "username=" + un + ";path=http://localhost:8080/moviebookingsystem/";
          document.cookie = "password=" + pass + ";path=http://localhost:8080/moviebookingsystem/";
         
         }
         return true;
         } 
         
         if("${Error}" != ""){
         
           toastr.options.closeButton = true;
                 toastr.options.positionClass = 'toast-top-center';
                 toastr.error("${Error}", 'Error');  
         }
         
         function show(a){
         toastr.options.closeButton = true;
         toastr.options.positionClass = 'toast-top-center';
         toastr.warning(a, ' warning');
         }
         
         
      </script>
      <script>
         function showUsernameModal() {
           $('#forgotPasswordUsername').val('');
           $('#usernameModal').modal('show');
           $("#usernameModalErrorMessage").text("");
         }
         
         function showNewPasswordModal() {
              $('#np').val('');
             $('#cp').val('');
         
             $('#newP').modal('show');
             $("#npem").text("");
           }
         
         $("#usernameModalSubmitButton").click(function() {
           var username = $("#forgotPasswordUsername").val();
           if (username.replace(/\s/g, '').length) {
             $.ajax({
               type: 'GET',
               url: "checkUsername",
               data: {
                 userName: username
               },
               success: function(data) {
                 if (data != "") {
                     var response = $.parseJSON(data.replace(/\n/g,"\\n"));
                   if (response["Exist"] == "Yes" && response["Active"] == "Yes") {
                     $("#usernameModalErrorMessage").text("");
                  toastr.options.closeButton = true;
                     toastr.options.positionClass = 'toast-top-center';
                     toastr.info('Generating OTP. Please wait.', 'Info');   
         
                     $.ajax({
                         type: 'POST',
                         url: "generateOtp",
                         data: {
                         		userName:username
                                },
                         success: function(data) {
                            if (data != "") {
                         	   
                         	   var response = $.parseJSON(data);
                         	   //bootbox.hideAll();
                         	    
                         	   
                         	   if(response["status"]=="OTP sent successfully")
                         		   {
                                    $('#usernameModal').modal('hide');
         
                         		   toastr.options.closeButton = true;
                                    toastr.options.positionClass = 'toast-top-center';
                                    toastr.success('OTP sent', 'Success');  
         
                                    $("#codeModal").modal("show");
                                    $('#code').val('');
         
                         		   
                         		   }
                         	   else
                         		   {
                         		   toastr.options.closeButton = true;
                                    toastr.options.positionClass = 'toast-top-center';
                                    toastr.error('OTP generation failed.', 'Error');  
         
                         		   }
                         	   
                         	   
         
                                           }
                            
                            
                            
                                    }
                             });		
                   }
                   else if(response["Exist"] == "Yes" && response["Active"] == "No"){
                       $("#usernameModalErrorMessage").text("User inactivated");
         
                   }
                   else {
                     $("#usernameModalErrorMessage").text("User does not exist");
                   }
                 }
               }
             });
           } else {
             $("#usernameModalErrorMessage").text("Please provide a username");
           }
         });
         
         
         
         $("#codeModalSubmitButton").click(function() {
         var code = $("#code").val();
         var username = $("#forgotPasswordUsername").val();
         
         if (code.replace(/\s/g, '').length) {
         
         $.ajax({
         type: 'POST',
         url: "verifyOtp",
         data: {
         otp:code,
         userName:username
         },
         success: function(data) {
         if (data != "") {
         var response = $.parseJSON(data);
         
         if(response["status"]=="verified")
           {
                  $("#codeModal").modal("hide");
         
          toastr.options.closeButton = true;
                  toastr.options.positionClass = 'toast-top-center';
                  toastr.success('You are verified', 'Success');
         	     showNewPasswordModal();
         	     
         	     
         
                 
         
           
           }
         if(response["status"]=="not verified")
          {
         $("#code").val("");
          toastr.options.closeButton = true;
                  toastr.options.positionClass = 'toast-top-center';
                  toastr.warning("Incorrect OTP.");  
           
          }
           
         }
         }
         }); 
         }
         else {
         $("#codeModalErrorMessage").text("Please enter OTP and submit");
         }
         
         });
         
         $("#npsubmit").click(function() {
         
         var username = $("#forgotPasswordUsername").val();
         var np = $("#np").val();
         var cp = $("#cp").val();
         if(np != '' && cp != ''){
         let pattern1 = /[a-z]/;
             let pattern2 = /[A-Z]/;
             let pattern3 = /[0-9]/;
             let pattern4 = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
             
             
             
             if (!(pattern1.test(np) && pattern2.test(np) && pattern3.test(np) && pattern4.test(np))) {
             show('Password must have atleast one lowercase letter, uppercase letter, number and special character');
               return;
             }
         if(np!=cp){
         	 $("#npem").text("passwords did not match");
         
          return;
         }
         else{
          $.ajax({
         	 type:"POST",
         	 url:"resetpassword",
         	 data:{
         		 userName:username,
         		 password:np
         	 },
         	 async:false,
         	 success:function(data){
         		 if(data != null){
         			toastr.options.closeButton = true;
          	        toastr.options.positionClass = 'toast-top-center';
          	        toastr.success('Password changed successfully', 'Success');
          	        $('#newP').modal('hide');
         		 }
         	 }
          })
         }
         }
         else{
         $("#npem").text("Please enter the values");
         
         }
         
         
         
         
         });
      </script>
   </body>
</html>
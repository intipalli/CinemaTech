<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Manage cards</title>
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
         <button class="btn btn-primary" onclick="showaddcardmodal()">Add Card</button>
         <br>
         <br>
         <div class="row">
            <div class="col col-md-4 col-sm-12">
               <label><i>Primary/Default Card</i></label>
               <div class="card" style="width: 21rem;">
                  <div class="card-body">
                     <h6 class="card-title" id="pccn">Card Number: XXXX XXXX XXXX 1234</h6>
                     <br>
                     <h6 class="card-subtitle mb-2 text-muted" id="pce">Expiry: 10/25</h6>
                     <br>
                     <h6 class="card-subtitle mb-2 text-muted" id="pccvv">CVV: XXX</h6>
                     <br>
                     <h6 class="card-subtitle mb-2 text-muted" id="pcct">Credit</h6>
                     <br>
                     <button class="btn btn-sm btn-outline-success" id="pcedit" onclick="edit(this)">Edit</button>
                  </div>
               </div>
            </div>
            <div class="col col-md-4 col-sm-12" id="ac1" style="display:none;">
               <label></label>
               <div class="card" style="width: 21rem;">
                  <div class="card-body">
                     <h6 class="card-title" id="ac1cn">Card Number: XXXX XXXX XXXX 1234</h6>
                     <br>
                     <h6 class="card-subtitle mb-2 text-muted" id="ac1e">Expiry: 10/25</h6>
                     <br>
                     <h6 class="card-subtitle mb-2 text-muted" id="ac1cvv">CVV: XXX</h6>
                     <br>
                     <h6 class="card-subtitle mb-2 text-muted" id="ac1ct">Debit</h6>
                     <br>
                     <button class="btn btn-sm btn-outline-success" id="ac1edit" onclick="edit(this)">Edit</button>
                     <button class="btn btn-sm btn-outline-danger" id="ac1remove" onclick="remove(this)">Remove</button>
                     <button class="btn btn-sm btn-outline-secondary" id="ac1primary" onclick="primary(this)">Set as primary</button>
                  </div>
               </div>
            </div>
            <div class="col col-md-4 col-sm-12" id="ac2" style="display:none;">
               <label></label>
               <div class="card" style="width: 21rem;">
                  <div class="card-body">
                     <h6 class="card-title" id="ac2cn">Card Number: XXXX XXXX XXXX 1234</h6>
                     <br>
                     <h6 class="card-subtitle mb-2 text-muted" id="ac2e">Expiry: 10/25</h6>
                     <br>
                     <h6 class="card-subtitle mb-2 text-muted" id="ac2cvv">CVV: XXX</h6>
                     <br>
                     <h6 class="card-subtitle mb-2 text-muted" id="ac2ct">Debit</h6>
                     <br>
                     <button class="btn btn-sm btn-outline-success" id="ac2edit" onclick="edit(this)">Edit</button>
                     <button class="btn btn-sm btn-outline-danger" id="ac2remove" onclick="remove(this)">Remove</button>
                     <button class="btn btn-sm btn-outline-secondary" id="ac2primary" onclick="primary(this)">Set as primary</button>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- Modal HTML Markup -->
      <div id="addcardmodal" class="modal fade">
         <div class="modal-dialog" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h1 class="modal-title" id="title">Add Card</h1>
               </div>
               <div class="modal-body">
                  <div class="form-group">
                     <label class="control-label">Card Type</label>
                     <div>
                        <select class="form-control input-lg" id="cardtype">
                           <option value="2">Debit</option>
                           <option value="1">Credit</option>
                        </select>
                     </div>
                  </div>
                  <br>
                  <div class="form-group">
                     <label class="control-label">Card Number</label>
                     <div>
                        <input type="text" class="form-control input-lg" id="cardno" value="">
                     </div>
                  </div>
                  <br>
                  <div class="form-group">
                     <label class="control-label">Expiry Month</label>
                     <div>
                        <input type="number" class="form-control input-lg" min="1" max="12" id="emonth">
                     </div>
                  </div>
                  <br>
                  <div class="form-group">
                     <label class="control-label">Expiry Year</label>
                     <div>
                        <input type="number" class="form-control input-lg" min="2022" max="2030" id="eyear">
                     </div>
                  </div>
                  <br>
                  <div class="form-group">
                     <label class="control-label">CVV</label>
                     <div>
                        <input type="password" class="form-control input-lg" id="cvv">
                     </div>
                  </div>
                  <br>
                  <div class="form-group">
                     <div>
                        <button type="button" class="btn btn-success" id="button" onclick="addcard()">Add</button>
                     </div>
                  </div>
               </div>
            </div>
            <!-- /.modal-content -->
         </div>
         <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script>
         function showaddcardmodal(){
         	$("#title").text("Add Card");
         	$("#button").text("Add Card");
         
         	$("#button").attr("onclick","addcard()");
         
         	$("#addcardmodal").modal("show");
         	
         	$("#cardno").val("");
         	$("#emonth").val("");
         	$("#eyear").val("");
         	 $("#cvv").val("");
         }
         
         
         function redirectToLogin(){
         	window.location.href = "login";
         
         }
         
         function remove(t){
         	var id=t.getAttribute("name");
         	$.ajax({
         		type:"POST",
         		url:"removecard",
         		data:{
         			id:id
         		},
         		async:false,
         		success:function(data){
         			var res = $.parseJSON(data);
         			if(res.hasOwnProperty("Success")){
         				toastr.options.closeButton = true;
         		        toastr.options.positionClass = 'toast-top-center';
         		        toastr.success(res.Success, 'Success');
         		        getCards();
         			}
         			
         			}
         	});
         }
         
         function primary(t){
         	var id=t.getAttribute("name");
         	$.ajax({
         		type:"POST",
         		url:"primarycard",
         		data:{
         			id:id
         		},
         		async:false,
         		success:function(data){
         			var res = $.parseJSON(data);
         			if(res.hasOwnProperty("Success")){
         				toastr.options.closeButton = true;
         		        toastr.options.positionClass = 'toast-top-center';
         		        toastr.success(res.Success, 'Success');
         		        getCards();
         			}
         			
         			}
         	});
         }
         
         function edit(t){
         	$("#title").text("Edit Card");
         	$("#addcardmodal").modal("show");
         	$("#button").text("Edit Card");
         
         
         	var id=t.getAttribute("name").split(",")[0];
         	var primary = t.getAttribute("name").split(",")[1];
         	$("#button").attr("onclick","editcard(" + id + "," + "'" +  primary  + "')");
         
         	$.ajax({
         		type:"POST",
         		url:"getcarddetails",
         		data:{
         			id:id,
         			primary:primary
         		},
         		async:false,
         		success:function(data){
         			var res = $.parseJSON(data);
         				$("#cardtype").val(res.ct);
         				$("#cardno").val(res.cn);
         				$("#emonth").val(res.em);
         				$("#eyear").val(res.ey);
         				$("#cvv").val(res.cvv);
         				
         			
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
         
         getCards();
         
         function getCards(){
         	document.getElementById("ac1").style.display="none";
         	document.getElementById("ac2").style.display="none";
         
         var userid = "${sessionScope.UserId}";
         	
         	
         	$.ajax({
         		type:"GET",
         		url:"getCards",
         		data:{
         			userid:userid
         		},
         		async:false,
         		success:function(data){
         			var res = $.parseJSON(data);
         			if(res.length == 1){
         			var primarycard = res[0];
         			$("#pccn").text("Card Number: XXXX-XXXX-XXXX-" + primarycard.cn );
         			$("#pce").text("Expiry: " + primarycard.em + "/" + primarycard.ey);
         			$("#pcct").text("Card Type: " + primarycard.ct);
         			$("#pcedit").attr("name",primarycard.id + "," + primarycard.primary);
         			}
         			else if(res.length == 2){
         				var primarycard = res[0];
         				$("#pccn").text("Card Number: XXXX-XXXX-XXXX-" + primarycard.cn);
         				$("#pce").text("Expiry: " + primarycard.em + "/" + primarycard.ey);
         				$("#pcct").text("Card Type: " + primarycard.ct);
         				$("#pcedit").attr("name",primarycard.id + "," + primarycard.primary);
         				
         				var ac1 = res[1];
         				$("#ac1cn").text("Card Number: XXXX-XXXX-XXXX-" + ac1.cn);
         				$("#ac1e").text("Expiry: " + ac1.em + "/" + ac1.ey);
         				$("#ac1ct").text("Card Type: " + ac1.ct);
         				$("#ac1edit").attr("name",ac1.id + "," + ac1.primary);
         				$("#ac1remove").attr("name",ac1.id);
          				$("#ac1primary").attr("name",ac1.id);
          			
         				document.getElementById("ac1").style.display="";
         
         				}
         			else if(res.length == 3){
         				var primarycard = res[0];
         				$("#pccn").text("Card Number: XXXX-XXXX-XXXX-" + primarycard.cn);
         				$("#pce").text("Expiry: " + primarycard.em + "/" + primarycard.ey);
         				$("#pcct").text("Card Type: " + primarycard.ct);
         				$("#pcedit").attr("name",primarycard.id + "," + primarycard.primary);
         				
         				var ac1 = res[1];
         				$("#ac1cn").text("Card Number: XXXX-XXXX-XXXX-" + ac1.cn);
         				$("#ac1e").text("Expiry: " + ac1.em + "/" + ac1.ey);
         				$("#ac1ct").text("Card Type: " + ac1.ct);
         				$("#ac1edit").attr("name",ac1.id + "," + ac1.primary);
         				$("#ac1remove").attr("name",ac1.id);
         				$("#ac1primary").attr("name",ac1.id);
          			
         				var ac2 = res[2];
         				$("#ac2cn").text("Card Number: XXXX-XXXX-XXXX-" + ac2.cn);
         				$("#ac2e").text("Expiry: " + ac2.em + "/" + ac2.ey);
         				$("#ac2ct").text("Card Type: " + ac2.ct);
         				$("#ac2edit").attr("name",ac2.id + "," + ac2.primary);
         				$("#ac2remove").attr("name",ac2.id);
          				$("#ac2primary").attr("name",ac2.id);
          			
         				document.getElementById("ac1").style.display="";
         				document.getElementById("ac2").style.display="";
         
         
         				
         				}
         			else{
         				
         			}
         		}
         	});
         	
         }
         
         
         function addcard(){
         	var userid = "${sessionScope.UserId}";
         	
         	var cn = $("#cardno").val();
         	var ct = $("#cardtype").val();
         	var emonth = $("#emonth").val();
         	var eyear = $("#eyear").val();
         	var cvv = $("#cvv").val();
         	if(cn != "" && ct != "" && emonth != "" && eyear != "" && cvv != ""){ 
         	$.ajax({
         		type:"POST",
         		url:"addcard",
         		data:{
         			userid:userid,
         			cardnumber:cn,
         			ct:ct,
         			emonth:emonth,
         			eyear:eyear,
         			cvv:cvv
         		},
         		async:false,
         		success:function(data){
         			var res = $.parseJSON(data);
         			if(res.hasOwnProperty("Success")){
         				$("#addcardmodal").modal("hide");
         				toastr.options.closeButton = true;
         		        toastr.options.positionClass = 'toast-top-center';
         		        toastr.success(res.Success, 'Success');
         		        getCards();
         				
         			}
         			else{
         				$("#addcardmodal").modal("hide");
         
         				toastr.options.closeButton = true;
         		        toastr.options.positionClass = 'toast-top-center';
         		        toastr.error(res.Error, 'Error');
         
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
         
         function editcard(id,primary){
         	
         	var cn = $("#cardno").val();
         	var ct = $("#cardtype").val();
         	var emonth = $("#emonth").val();
         	var eyear = $("#eyear").val();
         	var cvv = $("#cvv").val();
         	if(cn != "" && ct != "" && emonth != "" && eyear != "" && cvv != ""){ 
         	$.ajax({
         		type:"POST",
         		url:"editcard",
         		data:{
         			id:id,
         			primary:primary,
         			cardnumber:cn,
         			ct:ct,
         			emonth:emonth,
         			eyear:eyear,
         			cvv:cvv
         		},
         		async:false,
         		success:function(data){
         			var res = $.parseJSON(data);
         			if(res.hasOwnProperty("Success")){
         				$("#addcardmodal").modal("hide");
         				toastr.options.closeButton = true;
         		        toastr.options.positionClass = 'toast-top-center';
         		        toastr.success(res.Success, 'Success');
         		        getCards();
         				
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
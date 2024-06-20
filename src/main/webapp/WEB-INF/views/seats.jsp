<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Select seats</title>
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
         /* body {
         background: #eee linear-gradient(to bottom, #b6bcbf 0%, #E9E5F0 100%)
         } */
      </style>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" integrity="sha512-vKMx8UnXk60zUwyUnUPM3HbQo8QfmNx7+ltw8Pm5zLusl1XIfwcxo8DbWCqMGKaWeNxWA8yrx5v3SaVpMvR3CA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   </head>
   <body class="bg-light">
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
      <br><br>
      <div class="container mt-4 p-4 bg-white">
         <!-- <div class="mb-4">
            <h2><b>Seat Selection</b></h2>
            </div> -->
         <div class="row">
            <div class="col-md-8">
               <div class="card p-3">
                  <div>
                     <!--                     <h6 class="text-uppercase">Select a seat</h6>
                        -->  Select Seat(s)                  
                     <div style="float:right">
                        <button class="btn btn-sm btn-secondary" disabled>Booked</button>
                        <button class="btn btn-sm btn-outline-dark" disabled>Available</button>
                        <button class="btn btn-sm btn-dark" >Selected</button>
                     </div>
                  </div>
                  <br>
                  <table class="table bg-light " style='width:25%; margin-right: 300px;'>
                     <thead>
                        <tr>
                           <th></th>
                           <th>1</th>
                           <th>2</th>
                           <th>3</th>
                           <th>4</th>
                           <th>5</th>
                           <th>6</th>
                           <th>7</th>
                           <th></th>
                           <th>8</th>
                           <th>9</th>
                           <th>10</th>
                           <th>11</th>
                           <th>12</th>
                           <th>13</th>
                           <th>14</th>
                        </tr>
                     </thead>
                     <tbody id="allseats">
                     </tbody>
                  </table>
                  <hr style="height:25px;width:630px;">
                  <div id="noseats"></div>
                  <pre id="arrPrint"></pre>
               </div>
            </div>
            <div class="col-md-4">
               <div class="card card-blue p-3 text-black mb-3">
                  <h4><mark>Booking summary</mark></h4>
                  <br>
                  <h6 id="mname">Movie: Fun and Frustration</h6>
                  <h6 id="showdate" >Date: Dec 5, 2022</h6>
                  <h6 id="showtime">Time: 2:00PM</h6>
                  <h6 id="screen">Time: 2:00PM</h6>
                  <h6 id="seats"></h6>
                  <h6 id="Total"></h6>
               </div>
               <div class="card card-blue p-3 text-black mb-3">
                  <h5><mark>Price details</mark></h5>
                  <br>
                  <h6>Child: 5$</h6>
                  <h6>Adult: 10$</h6>
                  <h6>Senior: 15$</h6>
               </div>
               <div class="card card-blue p-3 text-black mb-3" id="audience">
               </div>
               <div class="card card-blue p-3 text-black mb-3">
                  <button class="btn btn-lg btn-success" onclick="checkout()">Checkout</button>
               </div>
            </div>
         </div>
      </div>
      <div id="checkoutmodal" class="modal fade">
         <div class="modal-dialog" role="document">
            <div class="modal-content">
               <div class="modal-header">
                  <h1 class="modal-title" id="title">Make Payment</h1>
               </div>
               <div class="modal-body">
                  <div class="form-group">
                     <label class="control-label" id="ticketprice"></label>
                  </div>
                  <br>
                  <div class="form-group">
                     <label class="control-label">Apply Promocode</label>
                     <div>
                        <input type="text" class="form-control input-lg" id="promocode" value=""><br>
                        <button class="btn btn-sm btn-primary" onclick="promotion()">Apply Promotion</button><br>
                        <p id="errormessage"></p>
                     </div>
                  </div>
                  <br>
                  <div class="form-group">
                     <label class="control-label">Choose card</label>
                     <div>
                        <select class="form-control input-lg" id="paymentcard">
                        </select><br>
                        <button class="btn btn-sm btn-primary" onclick="addcard()">Add Card</button>
                     </div>
                     <br>
                  </div>
                  <br>
                  <div class="form-group">
                     <label class="control-label">Enter CVV</label>
                     <div>
                        <input type="password" class="form-control input-lg" id="cvv" value="">
                     </div>
                  </div>
                  <br>
                  <div class="form-group">
                     <div>
                        <button type="button" class="btn btn-success" id="button" onclick="pay()">Pay</button>
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
         var userid = "${sessionScope.UserId}";
         
         function addcard(){
          window.location.href="managecards";
         }
         //alert(userid);
         
         var data = '${moviedata}';
         var res = $.parseJSON(data);
         setSeats();
         
         function setSeats(){
          $("#mname").text("Movie: " + res.mname);
          $("#showdate").text("Date: " + res.showdate);
          $("#showtime").text("Time: " + res.showtime);
          $("#screen").text("Screen: " + res.screen);
         
          var row = "";
          var ch = 'A';
          for(var i=1;i<=10;i++){
         	 row="<tr><td>" + ch + "</td>";
         	 for(var j=1;j<=14;j++){
         		if(j==8){
         			row+="<td></td>";
         		}
         		 var seatno = ch + j.toString();
         		 if((res.seats).includes(seatno)){
         			 row += "<td><button class='btn btn-md btn-secondary' name='" + seatno + "' disabled></button></td>";
         			
         		 }
         		 else{
         			 row += "<td><button class='btn btn-md btn-outline-dark' onclick='clickSeat(this)' name='" + seatno + "'></button></td>";
         
         		 }
         	 
         	 }
         	 row += "</tr>";
         	 $("#allseats").append(row);
         	 ch = String.fromCharCode(ch.charCodeAt(0) + 1);
         	 
         	}
          
         }
            var count = 0;
            var s = [];
         function clickSeat(t){
         if(!s.includes(t.getAttribute("name"))){
         if(count < 4 ){
         	if(t.className == "btn btn-md btn-outline-dark"){
                 t.className = "btn btn-md btn-dark";
                 count = count  + 1;
         		s.push(t.getAttribute("name"));
         		$("#audience").append('<div class="ticket-row"><label id="' + t.getAttribute("name") + '">' + t.getAttribute("name") + '</label> <select onchange="price()" class="sel">'+
                          '<option value="" selected disabled>Choose type of audience</option><option value="child">Child</option><option value="adult">Adult</option><option value="senior">Senior</option></select></div><br>');
         	        document.getElementById("noseats").innerHTML = "You have selected " + count + " seats";
             }
             
         	}
         else{
         	
         	toastr.options.closeButton = true;
                toastr.options.positionClass = 'toast-top-center';
                toastr.warning("You cannot select more than 4 seats", 'Warning');
         
         
            
         }
         }
         else{
                 t.className = "btn btn-md btn-outline-dark";
                 count = count - 1;
         	        document.getElementById("noseats").innerHTML = "You have selected " + count + " seats";
         	         var index = s.indexOf(t.getAttribute("name"));
                 if (index !== -1) {
                   s.splice(index, 1);
                 }
                 document.getElementById(t.getAttribute("name")).parentElement.nextElementSibling.remove();
                 document.getElementById(t.getAttribute("name")).parentElement.remove();
         
         
         
             
         }
         $("#seats").text("Seats: " + s);
         }
      </script>
      <script>
         var total=0;
         
         function price(){
         	total=0;
         	var arr = document.getElementsByClassName("sel");
         	for(var i=0;i<arr.length;i++){
         		if(arr[i].value == "child"){
         			total += 5;
         		}
         		else if(arr[i].value == "adult"){
         			total += 10;
         		}
         		else if(arr[i].value == "senior"){
         			total += 15;
         		}
         		else{
         			
         		}
         			
         			
         	}
         	$("#Total").text("Total amount: " + total + "$");
         }
         
         function checkout(){
         	if(s.length == 0){
         		toastr.options.closeButton = true;
                 toastr.options.positionClass = 'toast-top-center';
                 toastr.warning('select atleast 1 seat', 'Warning');
         
         	}
         	else{
         		var arr = document.getElementsByClassName("sel");
         		var flag=0;
         		for(var i=0;i<arr.length;i++){
         			if(arr[i].value == ""){
         				flag=1;
         		        break;
         			}
         		}
         		if(flag==0){
         			if( userid != ""){
         			$("#checkoutmodal").modal("show");
         			$("#ticketprice").text("Total price: " + total + "$");
         			$.ajax({
         				type:"GET",
         				url:"getCards",
         				data:{
         					userid:"${sessionScope.UserId}"
         				},
         				async:false,
         				success:function(data){
         					var res = $.parseJSON(data);
         					var pc = res[0];
         					$("#paymentcard").append("<option name='0' value='" + pc.id + "' selected>" + "XXXX-XXXX-XXXX-" + pc.cn + "</option>");
         					for(var i=1;i<res.length;i++){
         						$("#paymentcard").append("<option name='" + i + "' value='" + res[i].id + "'>" + "XXXX-XXXX-XXXX-" + res[i].cn + "</option>");
         
         					}
         				}
         				
         			});
         			}
         			else{
         				toastr.options.closeButton = true;
         	            toastr.options.positionClass = 'toast-top-center';
         	            toastr.warning('Please login to book the tickets', 'Warning');
          	            setTimeout(redirectToLogin, 5000);
          
         			}
         		}
         		else{
         			toastr.options.closeButton = true;
         	        toastr.options.positionClass = 'toast-top-center';
         	        toastr.warning('select type of audience for all seats', 'Warning');
         		}
         	}
         }
         
         
         function redirectToLogin(){
         	window.location.href = "login";
         	
         }
         
         function redirectToHistory(){
         	window.location.href = "bookinghistory";
         	
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
         
         function pay(){
         	var cn = $("#paymentcard").val();
         
         	var cvv = $("#cvv").val();
         	if(cvv != ""){
         		var mid = res.mid;
         		var mname = res.mname;
         		var sd = res.showdate;
         		var st = res.showtime;
         		var screen = res.screen;
         		var seats = s.toString();
         		var price = total;
         		
         		$.ajax({
         			type:"POST",
         			url:"pay",
         			data:{
         				uid:userid,
         				mid:mid,
         				mname:mname,
         				sd:sd,
         				st:st,
         				screen:screen,
         				seats:seats,
         				price:price,
         				cvv:cvv,
         				cn:cn
         			},
         			async:false,
         			success:function(data){
         				var res = $.parseJSON(data);
         				if(res.hasOwnProperty("Success")){
         					toastr.options.closeButton = true;
         			        toastr.options.positionClass = 'toast-top-center';
         			        toastr.success(res.Success, 'Success');
         			        $("#checkoutmodal").modal("hide");
         		            setTimeout(redirectToHistory, 3000);
         
         				}
         				else{
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
                 toastr.warning('Please enter cvv', 'Warning');
         
         	}
         	
         }
         
         function promotion(){
         	var pcode = $("#promocode").val();
         	if(pcode != ""){
         		$.ajax({
         			type:"POST",
         			url:"applyPromo",
         			data:{
         				pcode:pcode,
         				price:total
         			},
         			async:false,
         			success:function(data){
         				var res = $.parseJSON(data);
         				if(res.hasOwnProperty("Success")){
         					$("#ticketprice").text("Updated Price: " + res.updatedprice + "$");
         					$("#errormessage").text("Promotion applied");
         
         				}
         				else{
         					$("#errormessage").text(res.Error);
         
         				}
         			}
         		});
         
         	}
         	else{
         		toastr.options.closeButton = true;
                 toastr.options.positionClass = 'toast-top-center';
                 toastr.warning('Enter promocode', 'Warning');
         	
         	}
         }
         
         
         
      </script>
   </body>
</html>
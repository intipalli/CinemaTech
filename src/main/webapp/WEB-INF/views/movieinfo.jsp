<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Movie</title>
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
         span{
         color:red;
         }
      </style>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" integrity="sha512-vKMx8UnXk60zUwyUnUPM3HbQo8QfmNx7+ltw8Pm5zLusl1XIfwcxo8DbWCqMGKaWeNxWA8yrx5v3SaVpMvR3CA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
   </head>
   <body style="background-color: #EEEEEE">
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
      <div class="container py-3">
         <div class="row bg-dark pt-4 pb-4">
            <div class="col-4 text-center">
               <img src="" id="picture" class="img-fluid rounded " height="300px" width="300px">
            </div>
            <div class="col-8 pt-5">
               <h2 class="text-danger" id="title"></h2>
               <br>
               <p class="text-white" id="category"></p>
               <p class="text-white" id="review"></p>
               <p class="text-white" id="rating"></p>
               <span id="other" class="text-white"></span><br><br>
               <button class="btn btn-sm btn-outline-danger" id="trailer" onclick="showModal(this)">Play trailer</button><br><br>
               <button class="btn btn-lg btn-danger" id="bt" style="display:none;" onclick="booktickets(this)">Book Tickets</button>
            </div>
         </div>
         <br>
         <div class="p-4 bg-dark">
            <div class="row">
               <h3 class="text-danger">Director</h3>
               <p id="director" class="text-white"></p>
            </div>
            <div class="row">
               <h3 class="text-danger">Producer</h3>
               <p id="producer" class="text-white"></p>
            </div>
            <div class="row">
               <h3 class="text-danger">Synopsis</h3>
               <p id="synopsis" class="text-white"></p>
            </div>
            <div class="row">
               <h3 class="text-danger">Cast</h3>
               <p id="cast" class="text-white"></p>
            </div>
         </div>
      </div>
      <div class="modal fade" id="playmovie" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content ">
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLongTitle">Watch Trailer</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <iframe width="420" height="345" id="video" src=""></iframe>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>
            </div>
         </div>
      </div>
      <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script>
         function showModal(pointer){
         	//alert(pointer.getAttribute("name"));
         		$("#video").attr("src",pointer.getAttribute("name"));
         
         	$("#playmovie").modal("show");
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
         
         var moviedata = '${moviedata}';
         //alert(moviedata);
         var res = $.parseJSON(moviedata);
         $("#picture").attr("src",res.image);
         $("#title").text(res.title);
         $("#category").text("Genre: " + res.category);
         $("#review").text("Review: " + res.review + "/5");
         $("#rating").text("MPAA-US film rating code: " + res.rating);
         $("#other").html(res.language + " <b>.</b> " + res.duration + " <b>.</b> " + res.releasedate);
         $("#trailer").attr("name",res.trailer);
         $("#bt").attr("name",res.mid);
         
         $("#director").text(res.director);
         $("#producer").text(res.producer);
         $("#synopsis").text(res.synopsis);
         $("#cast").text(res.cast);
         if(res.status == 1){
         document.getElementById("bt").style.display = "";
         }
         
         function booktickets(pointer){
         	window.location.href = "tickets?movie=" + pointer.getAttribute("name") + "&" + "name=" + res.title;
         }
         
      </script>
   </body>
</html>
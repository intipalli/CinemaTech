<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>home</title>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" integrity="sha512-vKMx8UnXk60zUwyUnUPM3HbQo8QfmNx7+ltw8Pm5zLusl1XIfwcxo8DbWCqMGKaWeNxWA8yrx5v3SaVpMvR3CA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
      <style>
         @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap');
         html {
         scroll-behavior: smooth
         }
         body{
         overflow-x: hidden;
         font-family: 'Roboto', sans-serif;
         line-height: 1.5;
         background-color: #282828;
         color: white;
         margin: 0
         }
         .navbar{
         text-transform: uppercase;
         font-weight: 600;
         font-size: .8rem;
         letter-spacing: .1rem;
         background-color: #262626 !important;
         }
         header,#result {
         position: relative;
         background-color: #383838;
         height: 75vh;
         min-height: 25rem;
         width: 100%;
         overflow: hidden
         }
         header img{
         position: absolute;
         top: 50%;
         left: 50%;
         min-width: 100%;
         min-height: 100%;
         width: auto;
         height: auto;
         z-index: 0;
         -ms-transform: translateX(-50%) translateY(-50%);
         -moz-transform: translateX(-50%) translateY(-50%);
         -webkit-transform: translateX(-50%) translateY(-50%);
         transform: translateX(-50%) translateY(-50%)
         }
         #result img {
         position: absolute;
         margin-left:50%;
         top:50%;
         z-index: 0;
         -ms-transform: translateX(-50%) translateY(-50%);
         -moz-transform: translateX(-50%) translateY(-50%);
         -webkit-transform: translateX(-50%) translateY(-50%);
         transform: translateX(-50%) translateY(-50%)
         }
         header .container,#result .container {
         position: relative;
         z-index: 2
         }
         header .overlay,#result .overlay {
         position: absolute;
         top: 0;
         left: 0;
         height: 100%;
         width: 100%;
         background-color: black;
         opacity: 0.5;
         z-index: 1
         }
         .carousel{
         box-shadow: 5px 10px 18px, black;
         }
         .carousel-item{    
         max-height: 400px;
         border-radius: 25px;
         opacity: 1;
         overflow: hidden;
         }
         .carousel-item:hover{
         opacity: 0.7
         }
         .heading
         {
         padding-top: 30px;
         align-content: left;
         color: #fff
         }
         footer{
         background-color: #393939;
         padding: 20px;
         }
         .releases{
         padding-bottom:  60px;
         }
         /* .play-btn
         {
         width: 50px;
         position: relative;
         top: -47% ;
         right: -36%;
         cursor: pointer;
         transition: 2.0s;
         opacity: 0;
         }
         .col-md-4:hover .play-btn
         {
         opacity: 1;
         }
         * {
         box-sizing: border-box;
         }
         .row {
         display: flex;
         padding-left: 20px;
         }
         .row1{
         display: flex;
         }
         .col-md-4 {
         flex: 20%;
         padding: 20px;
         }
         p{
         color: white;
         }
         */
         /* Media Query for devices withi coarse pointers and no hover functionality */
         /* This will use a fallback image instead of a video for devices that commonly do not support the HTML5 video element */
         @media (pointer: coarse) and (hover: none) {
         header {
         background: url('https://source.unsplash.com/XT5OInaElMw/1600x900') black no-repeat center center scroll;
         }
      </style>
   </head>
   <body style="background-color: #EEEEEE">
      <%
         response.addHeader("Pragma", "no-cache");
         response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
         response.addHeader("Cache-Control", "pre-check=0, post-check=0");
         response.setDateHeader("Expires", 0);
         %>
      <nav class="navbar navbar-expand-lg navbar-dark">
         <a class="navbar-brand" href="#">24 frames Movies</a>
         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
         <span class="navbar-toggler-icon"></span>
         </button>
         <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto ">
               <li class="nav-item active">
                  <a class="nav-link" href="home">Home</a>
               </li>
               <!--      <li class="nav-item">
                  <a class="nav-link" href="#">Book Tickets</a>
                  </li>
                  <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Select Location
                  </a>
                  <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">Athens</a>
                    <a class="dropdown-item" href="#">Atlanta</a>
                    <a class="dropdown-item" href="#">Winder</a>
                  </div>
                  </li> -->
               <!--  <li class="nav-item">
                  <a class="nav-link" href="#">Help</a>
                  </li> -->
               <li class="nav-item">
                  <input class="form-control mr-sm-2" type="search" id="mt" placeholder="Search movie by title"  aria-label="Search">
               </li>
               &nbsp;&nbsp;
               <li class="nav-item">
                  <button class="btn btn-outline-success my-2 my-sm-0" type="button" onclick="movietitle()">Search</button>
               </li>
               &nbsp;&nbsp;
               <li class="nav-item dropdown">
                  <select class="form-control btn btn-outline-light " id="category" onchange="category()">
                     <option value="" selected disabled>Category</option>
                     <option value="Horror">Horror</option>
                     <option value="Comedy">Comedy</option>
                     <option value="Action">Action</option>
                     <option value="Romance">Romance</option>
                  </select>
               </li>
               <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Account</a>
                  <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                     <a class="dropdown-item" href="editProfile">Edit Profile</a>
                     <a class="dropdown-item" onclick="logout()">Sign out</a>
                     <a class="dropdown-item" href="managecards">Manage cards</a>
                     <a class="dropdown-item" href="bookinghistory">My Bookings</a>
                  </div>
               </li>
            </ul>
         </div>
      </nav>
      <div class="modal fade" id="playtrailer" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content ">
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLongTitle">Watch Trailer</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <iframe width="420" height="345" id="youtube" src=""></iframe>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>
            </div>
         </div>
      </div>
      <div id="result" style="display:none;">
         <div class="overlay"></div>
         <img id="picture" src="" class="text-center">
         <div class="container h-100 ">
            <div class="d-flex h-100 text-center align-items-center">
               <div class="w-100 text-white ">
                  <a href="#" id="moviename" class="display-3 text-white" style="text-decoration:none;"></a>
                  <p class="lead mb-0" id="rating"></p>
                  <button class="btn btn-danger btn-lg" data-toggle="modal" data-target="#playtrailer" >Watch Trailer</button>
                  <!--         <button class="btn btn-danger btn-lg">Book Now</button>
                     -->      
               </div>
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
      <div class="container py-3" style="display:none;" id="categoryResult">
         <div class="row"  id="ns">
         </div>
         <br><br>
         <div class="row"  id="cs">
         </div>
      </div>
      <header id="header">
         <!-- darker overlay -->
         <div class="overlay"></div>
         <!-- background video -->
         <img src="light house.jpg">
         <!-- The header content -->
         <div class="container h-100 ">
            <div class="d-flex h-100 text-center align-items-center">
               <div class="w-100 text-white ">
                  <h1 class="display-3">The Lighthouse</h1>
                  <p class="lead mb-0 ">Two lighthouse keepers try to maintain their sanity while living on a remote and mysterious New England island in the 1890s. </p>
                  <button class="btn btn-light btn-lg" data-toggle="modal" data-target="#HomeModalCenter" >Watch Trailer</button>
                  <button class="btn btn-danger btn-lg">Book Now</button>
               </div>
            </div>
         </div>
      </header>
      <div class="modal fade" id="HomeModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content ">
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLongTitle">Watch Trailer</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <iframe width="420" height="345" src="https://www.youtube.com/embed/Hyag7lR8CPA"></iframe>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="UpcomingModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content ">
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLongTitle">Watch Trailer</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <iframe width="420" height="345" src="https://www.youtube.com/embed/aIsFywuZPoQ">
                  </iframe>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="UpcomingModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content ">
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLongTitle">Watch Trailer</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <iframe width="420" height="345" src="https://www.youtube.com/embed/8Qn_spdM5Zg"></iframe>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>
            </div>
         </div>
      </div>
      <div class="modal fade" id="UpcomingModalCenter3" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content ">
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLongTitle">Watch Trailer</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <iframe width="420" height="345" src="https://www.youtube.com/embed/AHmCH7iB_IM"></iframe>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
               </div>
            </div>
         </div>
      </div>
      <div class="releases" id="releases">
         <div class="container upcoming-releases">
            <h1 class="heading text-white">Upcoming releases</h1>
            <br>
            <div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
               <ol class="carousel-indicators">
                  <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                  <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                  <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
               </ol>
               <div class="carousel-inner">
                  <div class="carousel-item active">
                     <a href="https://youtu.be/aIsFywuZPoQ"><img class="d-block w-100 hover-zoom" src="blonde.jpg" alt="First slide"></a>
                     <div class="carousel-caption d-none d-md-block">
                        <h3>Blonde </h3>
                        <h6>A fictionalized chronicle of the inner life of Marilyn Monroe.</h6>
                        <button class="btn btn-danger btn-lg" data-toggle="modal" data-target="#exampleModalCenter" >Watch Trailer</button>
                     </div>
                  </div>
                  <div class="carousel-item">
                     <a href="https://youtu.be/JfVOs4VSpmA"><img class="d-block w-100 hover-zoom" src="starwars.jpg" alt="Second slide"></a>
                     <div class="carousel-caption d-none d-md-block">
                        <h3>Starwars: The Rise of Skywalker</h3>
                        <h6>In the riveting conclusion of the landmark Skywalker saga, new legends will be born-and the final battle for freedom is yet to come.</h6>
                        <button class="btn btn-danger btn-lg" data-toggle="modal" data-target="#UpcomingModalCenter2" >Watch Trailer</button>
                     </div>
                  </div>
                  <div class="carousel-item">
                     <a href="https://www.youtube.com/watch?v="><img class="d-block w-100 hover-zoom" src="creed.jpg" alt="Third slide"></a>
                     <div class="carousel-caption d-none d-md-block">
                        <h3>Creed 3</h3>
                        <h6>After dominating the boxing world, Adonis has been thriving in his career and family life. When a childhood friend and former boxing prodigy resurfaces, the face off between former friends is more than just a fight.</h6>
                        <button class="btn btn-danger btn-lg" data-toggle="modal" data-target="#UpcomingModalCenter3" >Watch Trailer</button>
                     </div>
                  </div>
               </div>
               <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
               <span class="carousel-control-prev-icon" aria-hidden="true"></span>
               <span class="sr-only">Previous</span>
               </a>
               <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
               <span class="carousel-control-next-icon" aria-hidden="true"></span>
               <span class="sr-only">Next</span>
               </a>
            </div>
         </div>
         <div class="container now-showing">
            <h1 class="heading text-white">Now Playing</h1>
            <br>
            <div id="carouselExampleIndicators2" class="carousel slide carousel-fade" data-ride="carousel">
               <ol class="carousel-indicators">
                  <li data-target="#carouselExampleIndicators2" data-slide-to="0" class="active"></li>
                  <li data-target="#carouselExampleIndicators2" data-slide-to="1"></li>
                  <li data-target="#carouselExampleIndicators2" data-slide-to="2"></li>
               </ol>
               <div class="carousel-inner">
                  <div class="carousel-item active">
                     <a href="https://www.youtube.com/watch?v=0pdqf4P9MB8"><img class="d-block w-100" src="lalaland.jpg" alt="First slide"></a>
                     <div class="carousel-caption d-none d-md-block">
                        <h3>La La Land</h3>
                        <h6>While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future.</h6>
                        <button class="btn btn-success btn-lg">Book Now</button>
                     </div>
                  </div>
                  <div class="carousel-item">
                     <a href="https://www.youtube.com/watch?v=ZQ-YX-5bAs0"><img class="d-block w-100" src="darthvader.jpg" alt="Second slide"></a>
                     <div class="carousel-caption d-none d-md-block">
                        <h3>Star Wars: Visions - Volume 2</h3>
                        <h6>Star Wars anthology series that will see some of the world's best anime creators bring their talent to this beloved universe.</h6>
                        <button class="btn btn-success btn-lg">Book Now</button>
                     </div>
                  </div>
                  <div class="carousel-item">
                     <a href="https://www.youtube.com/watch?v=giXco2jaZ_4"><img class="d-block w-100" src="topgun.jpg" alt="Third slide"></a>
                     <div class="carousel-caption d-none d-md-block">
                        <h3> Top Gun Maverick</h3>
                        <h6>After thirty years, Maverick is still pushing the envelope as a top naval aviator, but must confront ghosts of his past when he leads TOP GUN's elite graduates on a mission that demands the ultimate sacrifice from those chosen to fly it.</h6>
                        <button class="btn btn-success btn-lg">Book Now</button>
                     </div>
                  </div>
               </div>
               <a class="carousel-control-prev" href="#carouselExampleIndicators2" role="button" data-slide="prev">
               <span class="carousel-control-prev-icon" aria-hidden="true"></span>
               <span class="sr-only">Previous</span>
               </a>
               <a class="carousel-control-next" href="#carouselExampleIndicators2" role="button" data-slide="next">
               <span class="carousel-control-next-icon" aria-hidden="true"></span>
               <span class="sr-only">Next</span>
               </a>
            </div>
         </div>
      </div>
      <footer class="footer text-white" id="footer">
         <div class="container">
            <div class="row">
               <div class="col-4 offset-1 col-sm-2">
                  <h5>Links</h5>
                  <ul class="list-unstyled">
                     <li><a href="#">Home</a></li>
                     <li><a href="">About</a></li>
                     <li><a href="#">Menu</a></li>
                     <li><a href="">Contact</a></li>
                  </ul>
               </div>
               <!--   <div class="col-7 col-sm-5">
                  <h5>Our Address</h5>
                  <address>
                    1000, Clear Lake Drive<br>
                    Athens<br>
                    Georgia<br>
                    <span class="fa fa-phone fa-lg"></span> : +7777778907<br>
                    <span class="fa fa-fax fa-lg"></span> : +7777778908<br>
                    <span class="fa fa-envelope fa-lg"></span> : <a href="mailto:info@24frames.net">info@24frames.net</a>
                  </address>
                  </div>
                  -->
            </div>
            <div class="row justify-content-center">
               <div class="col-auto">
                  <p>&copy; Copyright 2023 24 Frames Movies</p>
               </div>
            </div>
         </div>
      </footer>
      <!-- Optional JavaScript -->
      <!-- jQuery first, then Popper.js, then Bootstrap JS -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script><script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script>
         function showModal(pointer){
         	//alert(pointer.getAttribute("name"));
         		$("#video").attr("src",pointer.getAttribute("name"));
         
         	$("#playmovie").modal("show");
         }
         
         function movietitle(){
         	var name = $("#mt").val();
         	if(name != ""){
         		$.ajax({
         			type:"POST",
         			url:"byName",
         			data:{
         				mtitle:name
         			},
         			async:false,
         			success:function(data){
         				if(data != null){
         					var res = $.parseJSON(data);
         					if(res.hasOwnProperty("Error")){
         						toastr.options.closeButton = true;
         				        toastr.options.positionClass = 'toast-top-center';
         				        toastr.error(res.Error, 'Error');
         					}
         					else{
         						document.getElementById("header").style.display = "none";
         						document.getElementById("releases").style.display = "none";
         						document.getElementById("result").style.display = "";
         						document.getElementById("categoryResult").style.display = "none";
         
         						document.body.style.backgroundColor = 'white';
         						
         						$("#picture").attr("src",res.image);
         						$("#moviename").text(res.name);
         						$("#moviename").attr("href","movieinfo?movie=" + res.mid);
         						$("#rating").text("MPAA-US film rating: " + res.rating);
         						$("#youtube").attr("src",res.youtube);
         					}
         				}
         			}
         			});
         		}
         	
         	else{
         		toastr.options.closeButton = true;
                 toastr.options.positionClass = 'toast-top-center';
                 toastr.warning('Please enter movie name', 'Warning');
         	}
         	
         }
         
         function category(){
         	var genre = $("#category").val();
         	$.ajax({
         		type:"POST",
         		url:"byCategory",
         		data:{
         			category:genre
         		},
         		async:false,
         		success:function(data){
         			if(data != null){
         				var res = $.parseJSON(data);
         				if(res.length != 0){
         					
         					document.getElementById("header").style.display = "none";
         					document.getElementById("releases").style.display = "none";
         					document.getElementById("result").style.display = "none";
         					document.getElementById("categoryResult").style.display = "";
         					document.body.style.backgroundColor = 'grey';
         					$("#ns").html("<h3 class='text-dark'>Now Showing</h3>");
         					$("#cs").html("<h3 class='text-dark'>Coming Soon</h3>");
         
         					for(var i=0;i<res.length;i++){
         						if(res[i].status == 1){
         							$("#ns").append("<div class='col-md-3'><img src='" + res[i].image + "' class='img-fluid' style='width:90%;border-radius: 25px'/><br>"+
         						      
         						      "<a href='movieinfo?movie=" + res[i].mid + "' class='text-white' style='text-decoration:none;'>" + res[i].name + "</a> &nbsp;&nbsp;&nbsp;<span class='text-white text-sm-left'>MPAA-US Film: "  + res[i].rating + "</span><br><button class='btn btn-sm btn-danger' name='" + res[i].youtube + "' onclick='showModal(this)'>Play Trailer</button></div>");
         							
         													
         						}
         						else{
         							$("#cs").append("<div class='col-md-3'><img src='" + res[i].image + "' class='img-fluid' style='width:90%;border-radius: 25px'/><br>"+
         								      
         								      "<a href='movieinfo?movie=" + res[i].mid + "' class='text-white' style='text-decoration:none;'>" + res[i].name + "</a> &nbsp;&nbsp;&nbsp;<span class='text-white text-sm-left'>MPAA-US Film: "  + res[i].rating + "</span><br><button class='btn btn-sm btn-danger' name='" + res[i].youtube + "' onclick='showModal(this)'>Play Trailer</button></div>");
         								
         						}
         						
         					}
         				}
         				else{
         					toastr.options.closeButton = true;
         			        toastr.options.positionClass = 'toast-top-center';
         			        toastr.error('No movies found', 'Error');	
         				}
         			}
         		}
         	
         		});
         	
         	
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
      </script>
   </body>
</html>
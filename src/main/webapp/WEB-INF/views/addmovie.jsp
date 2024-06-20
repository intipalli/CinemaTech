<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Add Movie</title>
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
                        <h3 class="display-4 text-center">Add movie</h3>
                        <br>
                        <div class="mb-3">
                           <label for="title" class="h5"><span>*</span> Movie title</label>
                           <input type="text" id="title" placeholder="Enter movie title" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="category" class="h5"><span>*</span> Category</label>
                           <select class="form-control" id="category">
                              <option value="" selected disabled>Choose genre</option>
                              <option value="Action">Action</option>
                              <option value="Horror">Horror</option>
                              <option value="Comedy">Comedy</option>
                              <option value="Romance">Romance</option>
                           </select>
                        </div>
                        <div class="mb-3">
                           <label for="language" class="h5"><span>*</span> Language</label>
                           <input type="text" id="language" placeholder="Enter movie language" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="release" class="h5"><span>*</span> Movie release date</label>
                           <input type="text" id="release" placeholder="Enter movie release date" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="duration" class="h5"><span>*</span> Movie duration in hours and minutes</label>
                           <input type="text" id="duration" placeholder="Enter movie duration" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="director" class="h5"><span>*</span> Director</label>
                           <input type="text" id="director" placeholder="Enter director name" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="producer" class="h5"><span>*</span> Producer</label>
                           <input type="text" id="producer" placeholder="Enter producer name" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="cast" class="h5"><span>*</span> Cast</label>
                           <input type="text" id="cast" placeholder="Enter names of the actors" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="syn" class="h5"><span>*</span> Synopsis</label>
                           <textarea id="syn" 
                              class="form-control"></textarea>
                        </div>
                        <div class="mb-3">
                           <label for="review" class="h5"><span>*</span> Choose review</label>
                           <select class="form-control" id="review">
                              <option value="" selected disabled>Provide review out of 5</option>
                              <option value="1">1</option>
                              <option value="1.5">1.5</option>
                              <option value="2">2</option>
                              <option value="2.5">2.5</option>
                              <option value="3">3</option>
                              <option value="3.5">3.5</option>
                              <option value="4">4</option>
                              <option value="4.5">4.5</option>
                           </select>
                        </div>
                        <div class="mb-3">
                           <label for="rating" class="h5"><span>*</span> MPAA-US film rating code</label>
                           <select class="form-control" id="rating">
                              <option value="" selected disabled>Choose rating</option>
                              <option value="G">G</option>
                              <option value="M">M</option>
                              <option value="R">R</option>
                              <option value="X">X</option>
                           </select>
                        </div>
                        <div class="mb-3">
                           <label for="trailer" class="h5"><span>*</span> Trailer </label>
                           <input type="text" id="trailer" placeholder="" 
                              class="form-control" />
                        </div>
                        <div class="mb-3">
                           <label for="picture" class="h5"><span>*</span> Upload movie picture</label>
                           <input type=file id="picture"  
                              class="form-control" />
                        </div>
                        <br>
                        <div>
                           <button class="btn btn-success" type="button" onclick="addMovie()">Add
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
         
         function addMovie(){
         	var mtitle = $("#title").val();
         	var genre = $("#category").val();
         	var language = $("#language").val();
         	var release = $("#release").val();
         	var duration = $("#duration").val();
         
         	var d = $("#director").val();
         	var p = $("#producer").val();
         	var c = $("#cast").val();
         	var syn = $("#syn").val();
         	var rev = $("#review").val();
         	var rating = $("#rating").val();
         	var trailer = $("#trailer").val();
         	var image = $("#picture").val();
         	image = image.split("\\")[2];
         
         	
         	 if(mtitle != "" && genre != "" && d != "" && p != "" && c != "" && syn != "" && rev != "" && rating != "" && trailer != "" && image != "" && language != "" && release != "" && duration != ""){
         		
         		$.ajax({
         			type:"POST",
         			url:"addMovie",
         			data:{
         				title:mtitle,
         				category:genre,
         				director:d,
         				producer:p,
         				cast:c,
         				synopsis:syn,
         				review:rev,
         				rat:rating,
         				video:trailer,
         				picture:image,
         				l:language,
         				r:release,
         				d:duration
         			},
         			async:false,
         			success:function(data){
         				if(data != null){
         					var res = $.parseJSON(data);
         					if(res.hasOwnProperty("Success")){
         						toastr.options.closeButton = true;
         			            toastr.options.positionClass = 'toast-top-center';
         			            toastr.success(res.Success, 'Success');
         			            $("#title").val("");
         			        	$("#category").val("");
         			        	$("#director").val("");
         			        	$("#producer").val("");
         			        	$("#cast").val("");
         			        	$("#syn").val("");
         			        	$("#review").val("");
         			        	$("#rating").val("");
         			        	$("#trailer").val("");
         			        	$("#picture").val("");
         			        	$("#language").val("");
         			        	$("#release").val("");
         			        	$("#duration").val("");
         
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
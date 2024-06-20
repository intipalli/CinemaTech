package com.uga.mbs;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UiController {
	private Connection con = null;
	Security obj = new Security();
	final private String sk = "secretkey";

	private void connect() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviebookingsystem", "root", "Admin@2001");
	}

	private void disconnect() throws SQLException {
		con.close();
	}

	private static String getPropertyValue(String property, String filename) {
		String propertyValue = "";
		Properties prop = new Properties();
		InputStream input = null;

		try {

			input = Thread.currentThread().getContextClassLoader().getResourceAsStream(filename);
			prop.load(input);

			propertyValue = prop.getProperty(property);
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return propertyValue;
	}

	private static Session getSessionObject() {

		Properties props = new Properties();
		props.put("mail.smtp.auth", getPropertyValue("mail.smtp.auth", "email.properties"));
		props.put("mail.smtp.starttls.enable", getPropertyValue("mail.smtp.starttls.enable", "email.properties"));
		props.put("mail.smtp.host", getPropertyValue("mail.smtp.host", "email.properties"));
		props.put("mail.smtp.port", getPropertyValue("mail.smtp.port", "email.properties"));
		props.put("mail.smtp.from", getPropertyValue("from", "email.properties"));

		System.out.println("from is: " + props.getProperty("mail.smtp.from"));

		Authenticator auth = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(getPropertyValue("username", "email.properties"),
						getPropertyValue("password", "email.properties"));
			}
		};
		Session session = Session.getInstance(props, auth);
		return session;
	}

	public static void sendP(String emailId, String name, String promocode, int discount, String startdate,
			String enddate) throws IOException {

		String Subject = "24 Frames Movies promotion code";
		String body = "Hello " + name + ",\nPromotion details:\nCode: " + promocode + "\nDiscount: " + discount + "%"
				+ "\nValidity: " + startdate + " to " + enddate + "\n\nThank you,\n24 FramesMovies";

		try {

			Message message = new MimeMessage(getSessionObject());
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailId));
			message.setSubject(Subject);
			Multipart mp = new MimeMultipart();
			BodyPart bp = new MimeBodyPart();
			bp.setText(body);
			mp.addBodyPart(bp);
			message.setContent(mp);
			Transport.send(message);
		}

		catch (Exception e) {
			e.printStackTrace();

		}

	}

	@RequestMapping(value = "/addpromotion", method = RequestMethod.GET)
	public ModelAndView getAddPromotionPage(ModelAndView mv, HttpServletRequest request) {

		if (request.getSession().getAttribute("UserId") == null
				|| request.getSession().getAttribute("UserId").equals("")) {
			mv = new ModelAndView("login");
			return mv;
		} else {
			ModelAndView mav = new ModelAndView("addpromotion");
			return mav;
		}

	}

	@RequestMapping(value = "/addMovie", method = RequestMethod.GET)
	public ModelAndView getAddMoviePage(ModelAndView mv, HttpServletRequest request) {

		if (request.getSession().getAttribute("UserId") == null
				|| request.getSession().getAttribute("UserId").equals("")) {
			mv = new ModelAndView("login");
			return mv;
		} else {
			ModelAndView mav = new ModelAndView("addmovie");
			return mav;
		}

	}

	@RequestMapping(value = "/scheduleMovie", method = RequestMethod.GET)
	public ModelAndView getScheduleMoviePage(ModelAndView mv, HttpServletRequest request) {

		if (request.getSession().getAttribute("UserId") == null
				|| request.getSession().getAttribute("UserId").equals("")) {
			mv = new ModelAndView("login");
			return mv;
		} else {
			ModelAndView mav = new ModelAndView("schedulemovie");
			return mav;
		}

	}

	@RequestMapping(value = "/promotions", method = RequestMethod.GET)
	public ModelAndView getPromotionsPage(ModelAndView mv, HttpServletRequest request) {

		if (request.getSession().getAttribute("UserId") == null
				|| request.getSession().getAttribute("UserId").equals("")) {
			mv = new ModelAndView("login");
			return mv;
		} else {
			ModelAndView mav = new ModelAndView("promotions");
			return mav;
		}

	}

	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public ModelAndView getUsersPage(ModelAndView mv, HttpServletRequest request) {

		if (request.getSession().getAttribute("UserId") == null
				|| request.getSession().getAttribute("UserId").equals("")) {
			mv = new ModelAndView("login");
			return mv;
		} else {
			ModelAndView mav = new ModelAndView("users");
			return mav;
		}

	}

	@RequestMapping(value = "/addPromotion", method = RequestMethod.POST)
	@ResponseBody
	public String addPromotion(@RequestParam("promocode") String promocode, @RequestParam("dis") String dis,
			@RequestParam("startdate") String startdate, @RequestParam("enddate") String enddate,
			HttpServletRequest request) throws ClassNotFoundException, SQLException {
		connect();
		JSONObject json = new JSONObject();

		PreparedStatement stmt = con
				.prepareStatement("insert into promotions(discount,startdate,enddate,promocode)values(?,?,?,?);");
		stmt.setInt(1, Integer.parseInt(dis));
		stmt.setString(2, startdate);
		stmt.setString(3, enddate);
		stmt.setString(4, promocode);

		int i = stmt.executeUpdate();
		if (i > 0) {
			json.put("Success", "Promotion added successfully.");
			return json.toString();

		}
		return null;

	}

	private static void moveFile(String src, String dest) {
		Path result = null;
		try {
			result = Files.move(Paths.get(src), Paths.get(dest));
		} catch (IOException e) {
			System.out.println("Exception while moving file: " + e.getMessage());
		}
		if (result != null) {
			System.out.println("File moved successfully.");
		} else {
			System.out.println("File movement failed.");
		}
	}

	@RequestMapping(value = "/addMovie", method = RequestMethod.POST)
	@ResponseBody
	public String addMovie(@RequestParam("title") String title, @RequestParam("category") String category,
			@RequestParam("director") String director, @RequestParam("producer") String producer,
			@RequestParam("cast") String cast, @RequestParam("synopsis") String synopsis,
			@RequestParam("review") String review, @RequestParam("rat") String rating,
			@RequestParam("video") String video, @RequestParam("picture") String picture, @RequestParam("l") String l,
			@RequestParam("r") String r, @RequestParam("d") String d, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {

		moveFile("D:/MBS/movies/" + picture, "D:/MBS/moviebookingsystem/src/main/webapp/" + picture);

		connect();

		JSONObject json = new JSONObject();

		PreparedStatement stmt = con.prepareStatement(
				"insert into movie(title,category,director,producer,cast,synopsis,review,rating,trailer,image,language,releasedate,duration)values(?,?,?,?,?,?,?,?,?,?,?,?,?);");
		stmt.setString(1, title);
		stmt.setString(2, category);
		stmt.setString(3, director);
		stmt.setString(4, producer);
		stmt.setString(5, cast);
		stmt.setString(6, synopsis);
		stmt.setString(7, review);
		stmt.setString(8, rating);
		stmt.setString(9, "https://www.youtube.com/embed/" + video);
		stmt.setString(10, picture);
		stmt.setString(11, l);
		stmt.setString(12, r);
		stmt.setString(13, d);

		int i = stmt.executeUpdate();
		if (i > 0) {

			json.put("Success", "Movie added successfully.");
			return json.toString();

		}
		return null;

	}

	@RequestMapping(value = "/scheduleMovie", method = RequestMethod.POST)
	@ResponseBody
	public String scheduleMovie(@RequestParam("id") String id, @RequestParam("showdate") String showdate,
			@RequestParam("screenno") String screenno, @RequestParam("showtime") String showtime,
			HttpServletRequest request) throws ClassNotFoundException, SQLException {

		connect();

		JSONObject json = new JSONObject();

		PreparedStatement stmt = con
				.prepareStatement("select * from movieschedule where showdate=? and screenno=? and showtime=?;");
		stmt.setString(1, showdate);
		stmt.setInt(2, Integer.parseInt(screenno));
		stmt.setString(3, showtime);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			json.put("Error", "Show not available");
			return json.toString();
		} else {
			stmt = con
					.prepareStatement("insert into movieschedule(movieid,showdate,screenno,showtime)values(?,?,?,?);");
			stmt.setInt(1, Integer.parseInt(id));
			stmt.setString(2, showdate);
			stmt.setInt(3, Integer.parseInt(screenno));
			stmt.setString(4, showtime);
			stmt.executeUpdate();

			stmt = con.prepareStatement("update movie set status=? where movieid=?");
			stmt.setInt(1, 1);
			stmt.setInt(2, Integer.parseInt(id));
			stmt.executeUpdate();

			json.put("Success", "Movie scheduled successfully");
			return json.toString();
		}

	}

	@RequestMapping(value = "/editPromotion", method = RequestMethod.POST)
	@ResponseBody
	public String editPromotion(@RequestParam("pid") String promoid, @RequestParam("promocode") String promocode,
			@RequestParam("dis") String dis, @RequestParam("startdate") String startdate,
			@RequestParam("enddate") String enddate, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		connect();
		JSONObject json = new JSONObject();

		PreparedStatement stmt = con.prepareStatement(
				"update promotions set discount=?,startdate=?,enddate=?,promocode=? where promoid=?;");
		stmt.setInt(1, Integer.parseInt(dis));
		stmt.setString(2, startdate);
		stmt.setString(3, enddate);
		stmt.setString(4, promocode);
		stmt.setInt(5, Integer.parseInt(promoid));

		int i = stmt.executeUpdate();
		if (i > 0) {
			json.put("Success", "Promotion updated successfully.");
			return json.toString();

		}
		return null;

	}

	@RequestMapping(value = "/getPromos", method = RequestMethod.GET)
	@ResponseBody
	public String getPromos(HttpServletRequest request) throws ClassNotFoundException, SQLException {
		connect();
		JSONArray arr = new JSONArray();
		JSONObject json;

		PreparedStatement stmt = con.prepareStatement("select * from promotions;");

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			json = new JSONObject();
			json.put("pid", rs.getInt("PromoID"));
			json.put("pcode", rs.getString("PromoCode"));
			json.put("discount", rs.getInt("Discount"));
			json.put("sd", rs.getString("StartDate"));
			json.put("ed", rs.getString("EndDate"));
			json.put("sent", rs.getInt("sent"));

			arr.put(json);
		}
		return arr.toString();

	}

	@RequestMapping(value = "/getMovies", method = RequestMethod.GET)
	@ResponseBody
	public String getMovies(HttpServletRequest request) throws ClassNotFoundException, SQLException {
		connect();
		JSONArray arr = new JSONArray();
		JSONObject json;

		PreparedStatement stmt = con.prepareStatement("select * from movie");

		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			json = new JSONObject();
			json.put("mid", rs.getString("MovieId"));
			json.put("mname", rs.getString("Title"));

			arr.put(json);
		}
		return arr.toString();

	}

	@RequestMapping(value = "/getUsers", method = RequestMethod.GET)
	@ResponseBody
	public String getUsers(HttpServletRequest request) throws ClassNotFoundException, SQLException {
		connect();
		JSONArray arr = new JSONArray();
		JSONObject json;

		PreparedStatement stmt = con.prepareStatement("select * from user where role=?;");
		stmt.setInt(1, 2);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			json = new JSONObject();
			json.put("uid", rs.getInt("userid"));
			json.put("firstname", rs.getString("firstname"));
			json.put("lastname", rs.getString("lastname"));
			json.put("email", rs.getString("email"));
			json.put("status", rs.getInt("status"));

			arr.put(json);
		}
		System.out.println(arr.toString());
		return arr.toString();

	}

	@RequestMapping(value = "/suspendUser", method = RequestMethod.POST)
	@ResponseBody
	public String suspendUser(@RequestParam("uid") String userid, @RequestParam("e") String email,
			@RequestParam("name") String name, HttpServletRequest request) throws ClassNotFoundException, SQLException {
		connect();
		JSONObject json = new JSONObject();

		PreparedStatement stmt = con.prepareStatement("update user set status=? where userid=?;");
		stmt.setInt(1, 2);
		stmt.setInt(2, Integer.parseInt(userid));

		int i = stmt.executeUpdate();
		if (i > 0) {
			String Subject = "Your account is suspended";
			String body = "Hello " + name + ",\n\nYour account has been suspended.\n\nThank you,\n24 Frames Movies";

			try {

				Message message = new MimeMessage(getSessionObject());
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
				message.setSubject(Subject);
				Multipart mp = new MimeMultipart();
				BodyPart bp = new MimeBodyPart();
				bp.setText(body);
				mp.addBodyPart(bp);
				message.setContent(mp);
				Transport.send(message);
			}

			catch (Exception e) {
				e.printStackTrace();

			}

			json.put("Success", "Selected user is suspended");
			return json.toString();

		}
		return null;

	}

	@RequestMapping(value = "/unsuspendUser", method = RequestMethod.POST)
	@ResponseBody
	public String unsuspendUser(@RequestParam("uid") String userid, @RequestParam("e") String email,
			@RequestParam("name") String name, HttpServletRequest request) throws ClassNotFoundException, SQLException {
		connect();
		JSONObject json = new JSONObject();

		PreparedStatement stmt = con.prepareStatement("update user set status=? where userid=?;");
		stmt.setInt(1, 1);
		stmt.setInt(2, Integer.parseInt(userid));

		int i = stmt.executeUpdate();
		if (i > 0) {
			String Subject = "Your account is active now";
			String body = "Hello " + name
					+ ",\n\nYour account has been unsuspended. Your account is active now.\n\nThank you,\n24 Frames Movies";

			try {

				Message message = new MimeMessage(getSessionObject());
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
				message.setSubject(Subject);
				Multipart mp = new MimeMultipart();
				BodyPart bp = new MimeBodyPart();
				bp.setText(body);
				mp.addBodyPart(bp);
				message.setContent(mp);
				Transport.send(message);
			}

			catch (Exception e) {
				e.printStackTrace();

			}

			json.put("Success", "User is unsuspended. The status of the user is active now.");
			return json.toString();

		}
		return null;

	}

	@RequestMapping(value = "/sendPromotion", method = RequestMethod.POST)
	@ResponseBody
	public String sendPromotion(@RequestParam("promoid") String pid, HttpServletRequest request)
			throws ClassNotFoundException, SQLException, IOException {
		connect();
		JSONObject json = new JSONObject();
		PreparedStatement stmt = con.prepareStatement("select * from promotions where promoid=?");
		stmt.setInt(1, Integer.parseInt(pid));
		ResultSet rs = stmt.executeQuery();
		String promocode = "";
		int discount = 0;
		String startdate = "";
		String enddate = "";

		if (rs.next()) {
			promocode = rs.getString("promocode");
			discount = rs.getInt("discount");
			startdate = rs.getString("startdate");
			enddate = rs.getString("enddate");

		}
		stmt = con.prepareStatement("update promotions set sent=? where promoid=?");
		stmt.setInt(1, 1);
		stmt.setInt(2, Integer.parseInt(pid));

		int i = stmt.executeUpdate();
		if (i > 0) {
			stmt = con.prepareStatement("select email,firstname from user where subscribed=?");
			stmt.setInt(1, 1);

			rs = stmt.executeQuery();
			while (rs.next()) {
				sendP(rs.getString("email"), rs.getString("firstname"), promocode, discount, startdate, enddate);

			}

			json.put("Success", "Promotion sent successfully to all subscribed users");
			return json.toString();

		}
		return "";

	}

	@RequestMapping(value = "/byName", method = RequestMethod.POST)
	@ResponseBody
	public String searchByName(@RequestParam("mtitle") String mtitle, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		connect();
		JSONObject json = new JSONObject();

		PreparedStatement stmt = con.prepareStatement("select * from movie where upper(title)=?;");
		stmt.setString(1, mtitle.toUpperCase());
		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {

			json.put("Success", "Movie exists");
			json.put("name", rs.getString("title"));
			json.put("mid", rs.getInt("movieid"));
			json.put("rating", rs.getString("rating"));
			json.put("youtube", rs.getString("trailer"));
			json.put("image", rs.getString("image"));

			return json.toString();

		} else {
			json.put("Error", "Sorry. Movie does not found.");
			return json.toString();

		}

	}

	@RequestMapping(value = "/byCategory", method = RequestMethod.POST)
	@ResponseBody
	public String searchByCategory(@RequestParam("category") String genre, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		connect();
		JSONArray arr = new JSONArray();

		JSONObject json;

		PreparedStatement stmt = con.prepareStatement("select * from movie where category=?;");
		stmt.setString(1, genre);
		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {

			json = new JSONObject();
			json.put("name", rs.getString("title"));
			json.put("mid", rs.getInt("movieid"));
			json.put("rating", rs.getString("rating"));
			json.put("youtube", rs.getString("trailer"));
			json.put("image", rs.getString("image"));
			json.put("status", rs.getString("status"));

			arr.put(json);

		}
		return arr.toString();

	}

	@RequestMapping(value = "/movieinfo", method = RequestMethod.GET)
	public ModelAndView getMovieInfo(@RequestParam("movie") String id, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		connect();

		JSONObject json = new JSONObject();

		PreparedStatement stmt = con.prepareStatement("select * from movie where movieid=?;");
		stmt.setInt(1, Integer.parseInt(id));
		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {

			json.put("title", rs.getString("title"));
			json.put("mid", rs.getInt("movieid"));
			json.put("category", rs.getString("category"));
			json.put("director", rs.getString("Director"));
			json.put("producer", rs.getString("Producer"));
			json.put("cast", rs.getString("cast"));
			json.put("synopsis", rs.getString("synopsis"));
			json.put("review", rs.getString("review"));
			json.put("rating", rs.getString("rating"));
			json.put("trailer", rs.getString("trailer"));
			json.put("image", rs.getString("image"));
			json.put("status", rs.getString("status"));
			json.put("language", rs.getString("language"));
			json.put("releasedate", rs.getString("releasedate"));
			json.put("duration", rs.getString("duration"));

		}
		ModelAndView mv = new ModelAndView("movieinfo");
		mv.addObject("moviedata", json.toString());
		return mv;

	}

	@RequestMapping(value = "/tickets", method = RequestMethod.GET)
	public ModelAndView getdates(@RequestParam("movie") String id, @RequestParam("name") String title,
			HttpServletRequest request) throws ClassNotFoundException, SQLException {
		connect();

		JSONObject json = new JSONObject();
		JSONArray arr = new JSONArray();

		PreparedStatement stmt = con.prepareStatement("select distinct showdate from movieschedule where movieid=?;");

		stmt.setInt(1, Integer.parseInt(id));
		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
			arr.put(rs.getString("ShowDate"));
		}
		json.put("mid", id);
		json.put("dates", arr);
		json.put("name", title);

		ModelAndView mv = new ModelAndView("tickets");
		mv.addObject("dates", json.toString());
		return mv;

	}

	@RequestMapping(value = "/shows", method = RequestMethod.GET)
	@ResponseBody
	public String getShowTimings(@RequestParam("movieid") String mid, @RequestParam("showdate") String date,
			HttpServletRequest request) throws ClassNotFoundException, SQLException {
		connect();

		JSONObject json;
		JSONArray arr = new JSONArray();

		PreparedStatement stmt = con.prepareStatement("select * from movieschedule where movieid=? and showdate=?;");

		stmt.setInt(1, Integer.parseInt(mid));
		stmt.setString(2, date);

		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
			json = new JSONObject();
			json.put("screen", rs.getInt("ScreenNo"));
			json.put("time", rs.getString("showtime"));

			arr.put(json);
		}

		return arr.toString();

	}

}

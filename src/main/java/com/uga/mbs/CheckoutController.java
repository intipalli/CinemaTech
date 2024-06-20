package com.uga.mbs;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class CheckoutController {
	@RequestMapping(value = "/managecards", method = RequestMethod.GET)
	public ModelAndView getManageCardsPage(ModelAndView mv, HttpServletRequest request) {

		if (request.getSession().getAttribute("UserId") == null
				|| request.getSession().getAttribute("UserId").equals("")) {
			mv = new ModelAndView("login");
			return mv;
		} else {
			ModelAndView mav = new ModelAndView("managecards");
			return mav;
		}

	}

	Security obj = new Security();
	final private String sk = "secretkey";

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

	@RequestMapping(value = "/addcard", method = RequestMethod.POST)
	@ResponseBody
	public String addCard(@RequestParam("userid") String userid, @RequestParam("cardnumber") String cn,
			@RequestParam("ct") String ct, @RequestParam("emonth") String emonth, @RequestParam("eyear") String eyear,
			@RequestParam("cvv") String cvv, HttpServletRequest request) throws ClassNotFoundException, SQLException {
		Connection con = DbConnection.getInstance();
		JSONObject json = new JSONObject();
		PreparedStatement stmt = con.prepareStatement("select * from payment where UserId = ?");
		stmt.setInt(1, Integer.parseInt(userid));
		ResultSet rs = stmt.executeQuery();
		int count = 0;
		while (rs.next()) {
			count++;
		}
		if (count < 2) {
			stmt = con.prepareStatement(
					"insert into payment(UserId,CardType,CardNo,ExpiryMonth,ExpiryYear,CVV)values(?,?,?,?,?,?);");
			stmt.setInt(1, Integer.parseInt(userid));
			stmt.setInt(2, Integer.parseInt(ct));
			stmt.setString(3, obj.encrypt(cn, sk));
			stmt.setString(4, obj.encrypt(emonth, sk));
			stmt.setString(5, obj.encrypt(eyear, sk));
			stmt.setString(6, obj.encrypt(cvv, sk));

			int i = stmt.executeUpdate();
			if (i > 0) {
				json.put("Success", "Card added successfully.");
				return json.toString();

			}
		} else {
			json.put("Error", "Cannot add more than 3 cards");
			return json.toString();

		}

		return "";

	}

	@RequestMapping(value = "/editcard", method = RequestMethod.POST)
	@ResponseBody
	public String editCard(@RequestParam("id") String id, @RequestParam("primary") String primary,
			@RequestParam("cardnumber") String cn, @RequestParam("ct") String ct, @RequestParam("emonth") String emonth,
			@RequestParam("eyear") String eyear, @RequestParam("cvv") String cvv, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		Connection con = DbConnection.getInstance();
		;
		JSONObject json = new JSONObject();
		if (primary.equals("no")) {
			PreparedStatement stmt = con.prepareStatement(
					"update payment set cardtype=?,cardno=?,expirymonth=?,expiryyear=?,cvv=? where paymentid=?;");
			stmt.setInt(1, Integer.parseInt(ct));
			stmt.setString(2, obj.encrypt(cn, sk));
			stmt.setString(3, obj.encrypt(emonth, sk));
			stmt.setString(4, obj.encrypt(eyear, sk));
			stmt.setString(5, obj.encrypt(cvv, sk));
			stmt.setInt(6, Integer.parseInt(id));
			int i = stmt.executeUpdate();
			if (i > 0) {
				json.put("Success", "Card edited successfully.");
				return json.toString();

			}
		} else {
			PreparedStatement stmt = con.prepareStatement(
					"update user set card_type=?,card_number=?,expiry_month=?,expiry_year=?,cvv=? where userid=?;");
			stmt.setInt(1, Integer.parseInt(ct));
			stmt.setString(2, obj.encrypt(cn, sk));
			stmt.setString(3, obj.encrypt(emonth, sk));
			stmt.setString(4, obj.encrypt(eyear, sk));
			stmt.setString(5, obj.encrypt(cvv, sk));
			stmt.setInt(6, Integer.parseInt(id));
			int i = stmt.executeUpdate();
			if (i > 0) {
				json.put("Success", "Card edited successfully.");
				return json.toString();

			}
		}
		return "";
	}

	@RequestMapping(value = "/getCards", method = RequestMethod.GET)
	@ResponseBody
	public String getCards(@RequestParam("userid") String userid, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		Connection con = DbConnection.getInstance();
		;
		JSONObject json = null;
		JSONArray arr = new JSONArray();
		PreparedStatement stmt = con.prepareStatement("select * from user where UserId = ?");
		stmt.setInt(1, Integer.parseInt(userid));
		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			json = new JSONObject();
			json.put("id", rs.getString("userid"));

			json.put("ct", rs.getInt("card_type") == 1 ? "Credit" : "Debit");
			String cardnumber = obj.decrypt(rs.getString("card_number"), sk);
			cardnumber = cardnumber.substring(cardnumber.length() - 4);
			json.put("cn", cardnumber);
			json.put("em", obj.decrypt(rs.getString("expiry_month"), sk));
			json.put("ey", obj.decrypt(rs.getString("expiry_year"), sk));
			json.put("cvv", obj.decrypt(rs.getString("cvv"), sk));
			json.put("primary", "yes");
			arr.put(json);

		}
		stmt = con.prepareStatement("select * from payment where userid = ?;");
		stmt.setInt(1, Integer.parseInt(userid));

		rs = stmt.executeQuery();

		while (rs.next()) {
			json = new JSONObject();
			json.put("id", rs.getString("paymentid"));

			json.put("ct", rs.getInt("cardtype") == 1 ? "Credit" : "Debit");
			String cardnumber = obj.decrypt(rs.getString("cardno"), sk);
			cardnumber = cardnumber.substring(cardnumber.length() - 4);
			json.put("cn", cardnumber);
			json.put("em", obj.decrypt(rs.getString("expirymonth"), sk));
			json.put("ey", obj.decrypt(rs.getString("expiryyear"), sk));
			json.put("cvv", obj.decrypt(rs.getString("cvv"), sk));
			json.put("primary", "no");
			arr.put(json);

		}
		System.out.println(arr.toString());
		return arr.toString();

	}

	@RequestMapping(value = "/removecard", method = RequestMethod.POST)
	@ResponseBody
	public String removecard(@RequestParam("id") String id, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		Connection con = DbConnection.getInstance();
		;
		JSONObject json = new JSONObject();
		PreparedStatement stmt = con.prepareStatement("delete from payment where paymentid = ?;");
		stmt.setInt(1, Integer.parseInt(id));
		int i = stmt.executeUpdate();

		if (i > 0) {
			json.put("Success", "Card deleted");
			return json.toString();

		}
		return "";

	}

	@RequestMapping(value = "/primarycard", method = RequestMethod.POST)
	@ResponseBody
	public String primarycard(@RequestParam("id") int id, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		System.out.println("Hi: " + id);
		Connection con = DbConnection.getInstance();
		;
		JSONObject json = new JSONObject();
		PreparedStatement stmt = con.prepareStatement("select * from user where userid=?;");
		stmt.setInt(1, (int) request.getSession().getAttribute("UserId"));
		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			int pct = rs.getInt("card_type");
			String pcn = rs.getString("card_number");
			String pem = rs.getString("expiry_month");
			String pey = rs.getString("expiry_year");
			String pcvv = rs.getString("cvv");
			stmt = con.prepareStatement("select * from payment where paymentid=?;");
			stmt.setInt(1, id);
			rs = stmt.executeQuery();

			if (rs.next()) {
				int ct = rs.getInt("cardtype");
				String cn = rs.getString("cardno");
				String em = rs.getString("expirymonth");
				String ey = rs.getString("expiryyear");
				String cvv = rs.getString("cvv");

				stmt = con.prepareStatement(
						"update user set card_type=?,card_number=?,expiry_month=?,expiry_year=?,cvv=? where userid=?;");
				stmt.setInt(1, ct);
				stmt.setString(2, cn);
				stmt.setString(3, em);
				stmt.setString(4, ey);
				stmt.setString(5, cvv);
				stmt.setInt(6, (int) request.getSession().getAttribute("UserId"));
				stmt.executeUpdate();

				stmt = con.prepareStatement(
						"update payment set cardtype=?,cardno=?,expirymonth=?,expiryyear=?,cvv=? where paymentid=?;");
				stmt.setInt(1, pct);
				stmt.setString(2, pcn);
				stmt.setString(3, pem);
				stmt.setString(4, pey);
				stmt.setString(5, pcvv);
				stmt.setInt(6, id);
				stmt.executeUpdate();

				json.put("Success", "Primary card updated successfully");
				return json.toString();

			}

		}
		return "";

	}

	@RequestMapping(value = "/getcarddetails", method = RequestMethod.POST)
	@ResponseBody
	public String getcarddetails(@RequestParam("id") String id, @RequestParam("primary") String primary,
			HttpServletRequest request) throws ClassNotFoundException, SQLException {
		Connection con = DbConnection.getInstance();
		;
		JSONObject json = new JSONObject();
		if (primary.equals("yes")) {
			PreparedStatement stmt = con.prepareStatement("select * from user where UserId = ?");
			stmt.setInt(1, Integer.parseInt(id));
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				json.put("id", rs.getString("userid"));

				json.put("ct", rs.getInt("card_type"));
				json.put("cn", obj.decrypt(rs.getString("card_number"), sk));
				json.put("em", obj.decrypt(rs.getString("expiry_month"), sk));
				json.put("ey", obj.decrypt(rs.getString("expiry_year"), sk));
				json.put("cvv", obj.decrypt(rs.getString("cvv"), sk));

			}

		} else {
			PreparedStatement stmt = con.prepareStatement("select * from payment where PaymentId = ?");
			stmt.setInt(1, Integer.parseInt(id));
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				json.put("id", rs.getString("paymentid"));
				json.put("ct", rs.getInt("cardtype"));
				json.put("cn", obj.decrypt(rs.getString("cardno"), sk));
				json.put("em", obj.decrypt(rs.getString("expirymonth"), sk));
				json.put("ey", obj.decrypt(rs.getString("expiryyear"), sk));
				json.put("cvv", obj.decrypt(rs.getString("cvv"), sk));

			}
		}
		System.out.println(json.toString());
		return json.toString();

	}

	@RequestMapping(value = "/seats", method = RequestMethod.GET)

	public ModelAndView seatsPage(@RequestParam("mid") String mid, @RequestParam("showdate") String showdate,
			@RequestParam("showtime") String showtime, @RequestParam("mname") String mname,
			@RequestParam("screen") String screen, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		Connection con = DbConnection.getInstance();
		;
		JSONObject json = new JSONObject();
		PreparedStatement stmt = con
				.prepareStatement("select * from seats where movieid=? and showdate=? and showtime=? and screen=?");

		stmt.setInt(1, Integer.parseInt(mid));
		stmt.setString(2, showdate);
		stmt.setString(3, showtime);
		stmt.setInt(4, Integer.parseInt(screen));

		ResultSet rs = stmt.executeQuery();
		String seats = "";
		while (rs.next()) {

			seats += rs.getString("seats") + ",";
			System.out.println("seats are: " + seats);

		}

		json.put("mname", mname);
		json.put("mid", mid);
		json.put("showdate", showdate);
		json.put("showtime", showtime);
		json.put("screen", screen);
		if (seats != "") {
			json.put("seats", seats.substring(0, seats.length() - 1));
		} else {
			json.put("seats", "");

		}

		System.out.println(json.toString());
		ModelAndView mav = new ModelAndView("seats");
		mav.addObject("moviedata", json.toString());
		return mav;

	}

	@RequestMapping(value = "/applyPromo", method = RequestMethod.POST)
	@ResponseBody
	public String applyPromocode(@RequestParam("pcode") String pcode, @RequestParam("price") String ticketprice,
			HttpServletRequest request) throws ClassNotFoundException, SQLException, ParseException {
		Connection con = DbConnection.getInstance();
		;
		JSONObject json = new JSONObject();
		PreparedStatement stmt = con.prepareStatement("select * from promotions");

		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
			if (rs.getString("PromoCode").equalsIgnoreCase(pcode)) {
				String currentdate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

				String startdate = rs.getString("startdate");
				String enddate = rs.getString("enddate");

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date sd = sdf.parse(startdate);
				Date ed = sdf.parse(enddate);
				Date cd = sdf.parse(currentdate);

				int result1 = cd.compareTo(sd);
				int result2 = cd.compareTo(ed);

				if (result1 == 0 || result2 == 0 || (result1 > 0 && result2 < 0)) {

					int discount = (Integer.parseInt(ticketprice) * rs.getInt("discount")) / 100;
					int price = Integer.parseInt(ticketprice) - discount;

					json.put("Success", "promotion applied");
					json.put("updatedprice", price);

					return json.toString();
				} else {
					json.put("Error", "Promo code expired");
					return json.toString();

				}

			}

		}
		json.put("Error", "promotion code not available");

		return json.toString();

	}

	@RequestMapping(value = "/pay", method = RequestMethod.POST)
	@ResponseBody
	public String pay(@RequestParam("uid") String uid, @RequestParam("mid") String mid,
			@RequestParam("mname") String mname, @RequestParam("sd") String sd, @RequestParam("st") String st,
			@RequestParam("screen") String screen, @RequestParam("seats") String seats,
			@RequestParam("price") int price, @RequestParam("cvv") String cv, @RequestParam("cn") String cn,
			HttpServletRequest request) throws ClassNotFoundException, SQLException, ParseException {
		Connection con = DbConnection.getInstance();
		;
		JSONObject json = new JSONObject();
		PreparedStatement stmt = con.prepareStatement("select * from user where userid=?");
		stmt.setInt(1, Integer.parseInt(uid));
		ResultSet rs = stmt.executeQuery();
		rs.next();
		String email = rs.getString("email");

		stmt = con.prepareStatement(
				"insert into seats(userid,movieid,moviename,showdate,showtime,screen,seats,price)values(?,?,?,?,?,?,?,?);");
		stmt.setInt(1, Integer.parseInt(uid));
		stmt.setInt(2, Integer.parseInt(mid));
		stmt.setString(3, mname);
		stmt.setString(4, sd);
		stmt.setString(5, st);
		stmt.setString(6, screen);
		stmt.setString(7, seats);
		stmt.setInt(8, price);
		stmt.executeUpdate();
		String Subject = "Ticket details";
		String body = "Hi,\n\nYour tickets have been successfully booked.\n\nTicket details:\nMovie: " + mname
				+ "\nDate: " + sd + "\nTime: " + st + "\nScreen Number: " + screen + "\nSeats: " + seats
				+ "\nTotal price: " + price + "\n\nThank you,\n24 frames movies";

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
			System.out.println("Exception: " + e.getMessage());

		}

		json.put("Success", "Tickets Booked");
		return json.toString();

	}

	@RequestMapping(value = "/bookinghistory", method = RequestMethod.GET)
	public ModelAndView getHistoryPage(ModelAndView mv, HttpServletRequest request) {
		if (request.getSession().getAttribute("UserId") == null
				|| request.getSession().getAttribute("UserId").equals("")) {
			mv = new ModelAndView("login");
			return mv;
		} else {
			ModelAndView mav = new ModelAndView("bookinghistory");
			return mav;
		}
	}

	@RequestMapping(value = "/bookings", method = RequestMethod.GET)
	@ResponseBody
	public String bookings(@RequestParam("uid") String uid, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		Connection con = DbConnection.getInstance();
		;
		JSONObject json;
		JSONArray arr = new JSONArray();
		PreparedStatement stmt = con.prepareStatement("select * from seats where userid = ?;");
		stmt.setInt(1, Integer.parseInt(uid));
		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
			json = new JSONObject();
			json.put("id", rs.getInt("id"));

			json.put("mn", rs.getString("moviename"));
			json.put("sd", rs.getString("showdate"));
			json.put("st", rs.getString("showtime"));
			json.put("screen", rs.getInt("screen"));
			json.put("seats", rs.getString("seats"));
			json.put("price", rs.getInt("price"));

			arr.put(json);
		}
		return arr.toString();

	}

}

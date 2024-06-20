package com.uga.mbs;

import java.io.IOException;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;

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

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthController {

	private Connection con = null;
	Security obj = new Security();
	final private String sk = "secretkey";

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView getloginPage(HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("login");
		return mav;
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	@ResponseBody
	public String doLogout(ModelAndView mav, HttpServletRequest request) {
		try {
			disconnect();

			request.getSession().removeAttribute("UserId");
			return "";

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/registerPage", method = RequestMethod.GET)
	public ModelAndView getRegisterPage(ModelAndView mv, HttpServletRequest request) {

		mv = new ModelAndView("register");
		return mv;
	}

	@RequestMapping(value = "/editProfile", method = RequestMethod.GET)
	public ModelAndView getEditProfilePage(ModelAndView mv, HttpServletRequest request) {

		if (request.getSession().getAttribute("UserId") == null
				|| request.getSession().getAttribute("UserId").equals("")) {
			mv = new ModelAndView("login");
			return mv;
		} else {
			ModelAndView mav = new ModelAndView("editprofile");
			mav.addObject("UserId", request.getSession().getAttribute("UserId"));
			return mav;
		}
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView getHomePage(ModelAndView mv, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("home");
		return mav;

	}

	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public ModelAndView getAdminPage(ModelAndView mv, HttpServletRequest request) {
		if (request.getSession().getAttribute("UserId") == null
				|| request.getSession().getAttribute("UserId").equals("")) {
			mv = new ModelAndView("login");
			return mv;
		} else {
			ModelAndView mav = new ModelAndView("admin");
			return mav;
		}
	}

	private void connect() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviebookingsystem", "root", "Admin@2001");
	}

	private void disconnect() throws SQLException {
		con.close();
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView doLogin(@RequestParam("uname") String username, @RequestParam("upassword") String password,
			ModelAndView mav, HttpServletRequest request) throws ClassNotFoundException, SQLException {

		connect();
		if (con != null) {
			System.out.println("connected");

			PreparedStatement stmt = con.prepareStatement("select * from moviebookingsystem.user where username=?");
			stmt.setString(1, username);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				String pass = rs.getString("Password");
				String decryptedP = obj.decrypt(pass, sk);

				int role = rs.getInt("Role");
				int status = rs.getInt("Status");
				int userId = rs.getInt("UserID");
				if (status == 1) {
					if (decryptedP.equals(password)) {

						request.getSession().setAttribute("UserId", userId);

						if (role == 1) {
							ModelAndView mav1 = new ModelAndView("redirect:/admin");

							return mav1;
						} else {

							ModelAndView mav1 = new ModelAndView("redirect:/home");

							return mav1;
						}

					} else {

						mav.setViewName("login");
						mav.addObject("Error", "Wrong password");

						return mav;

					}
				} else if (status == 2) {

					mav.setViewName("login");

					mav.addObject("Error", "User is suspended. Kindly contact the admin.");

					return mav;
				} else {

					mav.setViewName("login");

					mav.addObject("Error", "Inactive user");

					return mav;
				}

			} else {
				mav.setViewName("login");
				mav.addObject("Error", "user does not exist");

				return mav;

			}
		}
		return null;

	}

	@RequestMapping(value = "/activateAcc", method = RequestMethod.GET)
	public ModelAndView activate(@RequestParam("userid") String userid, ModelAndView mv, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {
		connect();
		PreparedStatement ps = con.prepareStatement("update user set status=? where userid=?");
		ps.setInt(1, 1);
		ps.setInt(2, Integer.parseInt(userid));
		int i = ps.executeUpdate();
		if (i > 0) {
			mv = new ModelAndView("activated");
			return mv;
		}
		return mv;

	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public String doRegister(@RequestParam("firstName") String fn, @RequestParam("lastName") String ln,
			@RequestParam("username") String un, @RequestParam("EmailAdd") String email,
			@RequestParam("Mobile") String mob, @RequestParam("age") String age, @RequestParam("Password") String pwd,
			@RequestParam("cpassword") String cpwd, @RequestParam("cardtype") String ctype,
			@RequestParam("cardno") String cno, @RequestParam("cardcvv") String cvv, @RequestParam("expm") String em,
			@RequestParam("expy") String ey, @RequestParam("billinga") String ba, @RequestParam("checkbox") int cb,
			ModelAndView mav, HttpServletRequest request) throws ClassNotFoundException, SQLException {

		connect();
		JSONObject json = new JSONObject();
		if (con != null) {

			PreparedStatement stmt1 = con.prepareStatement("select * from user where username=?");
			stmt1.setString(1, un);
			ResultSet rs = stmt1.executeQuery();
			if (rs.next()) {

				json.put("Warning", "username exists");
				return json.toString();

			}
			stmt1 = con.prepareStatement("select * from user where email=?");
			stmt1.setString(1, email);
			rs = stmt1.executeQuery();
			if (rs.next()) {

				json.put("Warning", "email address exists");
				return json.toString();

			}
			stmt1 = con.prepareStatement("select * from user where phonenumber=?");
			stmt1.setString(1, mob);
			rs = stmt1.executeQuery();
			if (rs.next()) {

				json.put("Warning", "mobile number already exists");
				return json.toString();

			}
			PreparedStatement stmt = con.prepareStatement(
					"insert into user(password,firstname,lastname,email,phonenumber,status,role,age,username,subscribed,address,card_type,card_number,expiry_month,expiry_year,cvv) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			stmt.setString(1, obj.encrypt(pwd, sk));
			stmt.setString(2, fn);
			stmt.setString(3, ln);
			stmt.setString(4, email);
			stmt.setString(5, mob);
			stmt.setInt(6, 0);
			stmt.setInt(7, 2);
			stmt.setObject(8, Integer.parseInt(age));
			stmt.setString(9, un);
			stmt.setInt(10, 1);

			stmt.setString(11, ba);
			stmt.setInt(12, Integer.parseInt(ctype));
			stmt.setString(13, obj.encrypt(cno, sk));
			stmt.setString(14, obj.encrypt(em, sk));
			stmt.setString(15, obj.encrypt(ey, sk));
			stmt.setString(16, obj.encrypt(cvv, sk));

			int i = stmt.executeUpdate();
			if (i > 0) {
				stmt = con.prepareStatement("select userid from user where username=?");
				stmt.setString(1, un);
				rs = stmt.executeQuery();
				String uid = "";
				if (rs.next()) {
					uid += Integer.toString(rs.getInt("userid"));
				}
				json.put("Success", "success message");
				String Subject = "Registration confirmation";
				String body = "Hi\n You are registered to 24 frames movies. Your account is inactive. Please activate your account with the given link to signin.\n<a href='http://localhost:8080/moviebookingsystem/activateAcc?userid="
						+ uid + "'>activate account</a>";

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

				return json.toString();
			}

		}
		return null;

	}

	@RequestMapping(value = "/checkUsername", method = RequestMethod.GET)
	@ResponseBody
	public String showData(@RequestParam("userName") String un, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {

		connect();
		JSONObject json = new JSONObject();

		PreparedStatement stmt = con.prepareStatement("select * from moviebookingsystem.user where username=?");
		stmt.setString(1, un);

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			if (rs.getInt("Status") == 1) {
				json.put("Exist", "Yes");
				json.put("Active", "Yes");

			} else {
				json.put("Exist", "Yes");
				json.put("Active", "No");

			}
		} else {
			json.put("Exist", "No");

		}

		return json.toString();

	}

	@RequestMapping(value = "/getUserData", method = RequestMethod.GET)
	@ResponseBody
	public String getData(@RequestParam("uid") int userId) throws ClassNotFoundException, SQLException {

		JSONObject json = new JSONObject();

		PreparedStatement stmt = con.prepareStatement("select * from moviebookingsystem.user where userid=?");
		stmt.setInt(1, userId);

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			json.put("firstname", rs.getString("firstname"));
			json.put("lastname", rs.getString("lastname"));
			json.put("email", rs.getString("email"));
			json.put("password", obj.decrypt(rs.getString("password"), sk));
			json.put("address", rs.getString("address"));
			json.put("cardtype", rs.getInt("card_type"));
			json.put("cardno", obj.decrypt(rs.getString("card_number"), sk));
			json.put("expm", obj.decrypt(rs.getString("expiry_month"), sk));
			json.put("expy", obj.decrypt(rs.getString("expiry_year"), sk));
			json.put("cvv", obj.decrypt(rs.getString("cvv"), sk));
			json.put("subscribed", rs.getInt("subscribed"));

		}
		System.out.println(json.toString());
		return json.toString();

	}

	@RequestMapping(value = "/editProfile", method = RequestMethod.POST)
	@ResponseBody
	public String editProfile(@RequestParam("emailid") String email, @RequestParam("firstName") String fn,
			@RequestParam("lastName") String ln, @RequestParam("cardtype") int ct, @RequestParam("cardno") String cno,
			@RequestParam("cardcvv") String cvv, @RequestParam("expm") String em, @RequestParam("expy") String ey,
			@RequestParam("billinga") String add, @RequestParam("checkbox") int cb, HttpServletRequest request)
			throws ClassNotFoundException, SQLException {

		JSONObject json = new JSONObject();

		PreparedStatement stmt = con.prepareStatement(
				"update moviebookingsystem.user set firstName=?,lastName=?,address=?,card_type=?,card_number=?,expiry_month=?,expiry_year=?,cvv=?,subscribed=? where userid=?");
		stmt.setString(1, fn);
		stmt.setString(2, ln);
		stmt.setString(3, add);
		stmt.setInt(4, ct);
		stmt.setString(5, obj.encrypt(cno, sk));
		stmt.setString(6, obj.encrypt(em, sk));
		stmt.setString(7, obj.encrypt(ey, sk));
		stmt.setString(8, obj.encrypt(cvv, sk));
		stmt.setInt(9, cb);
		stmt.setInt(10, (int) request.getSession().getAttribute("UserId"));
		int i = stmt.executeUpdate();
		if (i > 0) {
			String Subject = "User profile updated";
			String body = "Hi " + fn + ",\n\nYour Profile has been updated.\n\n24 frames movies";

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

			json.put("Success", "Profile edited successfully");

		}
		return json.toString();

	}

	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	@ResponseBody
	public String changePassword(@RequestParam("cp") String cp, @RequestParam("np") String np,
			HttpServletRequest request) throws ClassNotFoundException, SQLException {

		JSONObject json = new JSONObject();
		PreparedStatement stmt1 = con.prepareStatement("select password from moviebookingsystem.user where userid=?");
		stmt1.setInt(1, (int) request.getSession().getAttribute("UserId"));

		ResultSet rs = stmt1.executeQuery();
		if (rs.next()) {
			if (obj.decrypt(rs.getString("password"), sk).equals(cp)) {
				PreparedStatement stmt = con
						.prepareStatement("update moviebookingsystem.user set password=? where userid=?");
				stmt.setString(1, obj.encrypt(np, sk));

				stmt.setInt(2, (int) request.getSession().getAttribute("UserId"));
				stmt.executeUpdate();
				json.put("Success", "Password changed successfully");
				return json.toString();

			} else {
				json.put("Error", "Current password is not correct");
				return json.toString();

			}
		}
		return np;

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

	public static JSONObject sendOtp(String emailId, String otp) throws IOException {

		JSONObject response = new JSONObject();
		String Subject = "User Validation";
		String body = "Your OTP is: " + otp;

		try {

			Message message = new MimeMessage(getSessionObject());
			System.out.println("hi");
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
			System.out.println("Exception: " + e.getMessage());
			response.put("error", "Exception happened: " + e.getMessage());
			return response;

		}
		response.put("status", "OTP sent successfully");
		return response;

	}

	@RequestMapping(value = "/generateOtp", method = RequestMethod.POST)
	@ResponseBody
	public String addUser(@RequestParam("userName") String un, HttpServletRequest request)
			throws ClassNotFoundException, SQLException, IOException {

		JSONObject response = new JSONObject();
		String query = "select email from user where username=?";
		String email = "";
		PreparedStatement stmt = con.prepareStatement(query);
		stmt.setString(1, un);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			email = rs.getString("email");
		} else {
			response.put("Error", "User does not exist");
			return response.toString();
		}
		Random rndm = new Random();
		int num = rndm.nextInt(999999);

		String otp = String.format("%06d", num);

		String otpQuery = "update user set otp=? where username=?";
		PreparedStatement stmt1 = con.prepareStatement(otpQuery);
		stmt1.setString(1, otp);
		stmt1.setString(2, un);

		int i = stmt1.executeUpdate();

		JSONObject js = sendOtp(email, otp);
		if (js.has("status")) {
			response.put("status", "OTP sent successfully");

		}
		return response.toString();

	}

	@RequestMapping(value = "/verifyOtp", method = RequestMethod.POST)
	@ResponseBody
	public String verifyOtp(@RequestParam("userName") String un, @RequestParam("otp") String code,
			HttpServletRequest request) throws ClassNotFoundException, SQLException, IOException {

		JSONObject response = new JSONObject();
		String query = "select otp from user where username=?";
		String otp = "";
		PreparedStatement stmt = con.prepareStatement(query);
		stmt.setString(1, un);
		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			otp = rs.getString("otp");
		}
		System.out.println(otp);
		if (otp.equals(code)) {
			response.put("status", "verified");

		} else {
			response.put("status", "not verified");

		}
		return response.toString();

	}

	@RequestMapping(value = "/resetpassword", method = RequestMethod.POST)
	@ResponseBody
	public String resetpassword(@RequestParam("userName") String un, @RequestParam("password") String p,
			HttpServletRequest request) throws ClassNotFoundException, SQLException, IOException {

		JSONObject response = new JSONObject();

		String query = "update user set Password=? where username=?";

		PreparedStatement stmt = con.prepareStatement(query);
		String encryptedP = obj.encrypt(p, sk);
		stmt.setString(1, encryptedP);
		stmt.setString(2, un);

		int r = stmt.executeUpdate();
		if (r > 1) {
			response.put("success", "true");
			return response.toString();
		}

		else {
			response.put("success", "false");
			return response.toString();
		}

	}

}

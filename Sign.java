package knuAirDB;

import java.util.Scanner;
import java.sql.*;

public class Sign {
	static Connection conn = null;
	static Statement stmt = null;
	Scanner sc = new Scanner(System.in);

	public Sign(Connection _conn, Statement _stmt) {
		conn = _conn;
		stmt = _stmt;
	}

	public Account Login(Identification _id) {
		String id = "";
		String pwd = "";

		System.out.print("ID : ");
		id = sc.nextLine();
		System.out.print("Pwd : ");
		pwd = sc.nextLine();

		// System.out.println("id : " + id + " pwd : " + pwd);
		// db에서 검색

		String sql = "select Type from account where AccountID = '" + id + "'and Pwd = '" + pwd + "'";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				_id.id = id;
				if (rs.getString(1).compareTo("Admin") == 0)
					return Account.Admin;
				else if (rs.getString(1).compareTo("Passenger") == 0)
					return Account.Passenger;
			} else
				return Account.NoExist;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return Account.Unknown;
	}

	public void Join() {
		int accountNo = -1;
		String id = "";
		String pwd = "";
		String fname = "";
		String lname = "";
		String age = "";
		String phone = "";
		String email = "";
		String sex = "";
		String address = "";
		String type = "";

		String sql = "select max(accountNo) from account";
		ResultSet rs;
		try {
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				accountNo = rs.getInt(1) + 1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.print("ID[최대 15자]: ");
		id = sc.nextLine();
		System.out.print("Pwd[최대 15자]: ");
		pwd = sc.nextLine();
		System.out.print("First Name[최대 15자]: ");
		fname = sc.nextLine();
		System.out.print("Last Name[최대 15자]: ");
		lname = sc.nextLine();
		System.out.print("Age: ");
		age = sc.nextLine();
		System.out.print("Phone Number[xxx-xxxx-xxxx]: ");
		phone = sc.nextLine();
		System.out.print("Email[최대 30자]: ");
		email = sc.nextLine();
		System.out.print("Sex[M or F]: ");
		sex = sc.nextLine();
		System.out.print("Address[최대 50자]: ");
		address = sc.nextLine();
		System.out.print("Who are you? [Admin or Passenger]: ");
		type = sc.nextLine();
		
		try {
			if(type.compareTo("Admin") == 0) {
				sql = "INSERT INTO ACCOUNT VALUES ('" + accountNo + "','" + id + "', '" + pwd + "', '" + fname + "','" + lname
						+ "','" + age + "', '" + phone + "','" + email + "', '" + sex + "', '" + address + "','" + type + "')";
				int result = stmt.executeUpdate(sql);
				conn.commit();
			} else if(type.compareTo("Passenger") == 0) {
				sql = "INSERT INTO ACCOUNT VALUES ('" + accountNo + "','" + id + "', '" + pwd + "', '" + fname + "','" + lname
						+ "','" + age + "', '" + phone + "','" + email + "', '" + sex + "', '" + address + "','" + type + "')";
				stmt.addBatch(sql);
				int membership_id = 20000000 + accountNo;
				sql = "INSERT INTO MEMBERSHIP VALUES ('" + membership_id + "','Silver', 0, '" + accountNo + "')";
				stmt.addBatch(sql);
				
				int count[] = stmt.executeBatch();
				conn.commit();	
			}
			System.out.println("[계정이 생성되었습니다.]");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}

	public void Logout() {

	}
}

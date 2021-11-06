package knuAirDB;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class knuAirDBTest {
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
	public static final String USER_UNIVERSITY = "knuAirDB";
	public static final String USER_PASSWD = "knu";
	static final Scanner sc = new Scanner(System.in);

	public static void main(String[] args) {
		Connection conn = null; // Connection object
		Statement stmt = null; // Statement object

		try {
			// Load a JDBC driver for Oracle DBMS
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD);
			// auto-commit disabled
			conn.setAutoCommit(false);
			// Create a statement object
			stmt = conn.createStatement();
		} catch (ClassNotFoundException e) {
			System.err.println("error = " + e.getMessage());
			System.exit(1);
		} catch (SQLException ex) {
			ex.printStackTrace();
			System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
			System.err.println("Cannot get a connection: " + ex.getMessage());
			System.exit(1);
		}

		mainMenu(conn, stmt);

		// Release database resources.
		try {
			// Close the Statement object.
			stmt.close();
			// Close the Connection object.
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void mainMenu(Connection conn, Statement stmt) {
		Identification id = new Identification();
		id.id = null;
		final Sign user = new Sign(conn, stmt);
		
		while (true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|              Welcom to knuAirDB             |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|          1. Login           2. Join         |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");

			switch (sc.nextLine()) {
			case "1":
				Account account = user.Login(id);
				if (account == Account.Admin) {
					System.out.println("[로그인 성공 : you are admin]");
					Admin admin = new Admin(conn, stmt, id);
				} else if (account == Account.Passenger) {
					System.out.println("[로그인 성공 : you are passenger]");
					Passenger passenger = new Passenger(conn, stmt, id);
				} else {
					System.out.println("[로그인 실패 : There is no such user!]");
				}
				break;
			case "2":
				user.Join();
				break;
			default:
				System.out.println("[Wrong input!!]");
				System.exit(1);
			}
		}

	}

}

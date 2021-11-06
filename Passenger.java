package knuAirDB;

import java.io.*;
import java.sql.*;
import java.util.Scanner;

public class Passenger {
	Connection conn = null;
	Statement stmt = null;
	String id = null;
	
	Scanner sc = new Scanner(System.in);

	public Passenger(Connection _conn, Statement _stmt, Identification _id) {
		conn = _conn;
		stmt = _stmt;
		id = _id.id;
		
		menu();
	}

	public void menu() {
		while (true) {
			System.out.println("+---------------------------------------------+");
			System.out.println("|                                             |");
			System.out.println("|                  Passenger                  |");
			System.out.println("|                                             |");
			System.out.println("|                                             |");
			System.out.println("|       1. Search        2. Reservation       |");
			System.out.println("|                                             |");
			System.out.println("|       3. My Page       4. Logout            |");
			System.out.println("|                                             |");
			System.out.println("|       5. DeleteAccount                      |");
			System.out.println("|                                             |");
			System.out.println("+---------------------------------------------+");
			System.out.print(">> ");

			switch (sc.nextLine()) {
			case "1":
				search();
				break;
			case "2":
				reservation();
				break;
			case "3":
				myPage();
				break;
			case "4":
				return;
			case "5":
				deleteAccount();
				return;
			default:
				System.out.println("Wrong input!!");
				System.exit(1);
			}
		}
	}

	public void search() {

	}

	public void reservation() {

	}

	public void myPage() {
		String sql = "select fname, lname, age, phone, email, sex, address, type, title, travel_count from account a, membership m where a.AccountID = '"
				+ id + "' and a.AccountNo = m.AccountNo";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				String fname = rs.getString(1);
				String lname = rs.getString(2);
				String age = rs.getString(3);
				String phone = rs.getString(4);
				String email = rs.getString(5);
				String sex = rs.getString(6);
				String address = rs.getString(7);
				String type = rs.getString(8);
				String m_title = rs.getString(9);
				int travel_count = rs.getInt(10);

				System.out.println("[ 내 정보 ]");
				System.out.println("| ID : " + id);
				System.out.println("| 성 : " + lname);
				System.out.println("| 이름 : " + fname);
				System.out.println("| 나이 : " + age);
				System.out.println("| 전화번호 : " + phone);
				System.out.println("| 이메일 : " + email);
				System.out.println("| 성별 : " + sex);
				System.out.println("| 주소 : " + address);
				System.out.println("| 계정 유형 : " + type);
				System.out.println("| 멤버십 등급 : " + m_title);
				System.out.println("| 비행 횟수 : " + travel_count);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("+---------------------------------------------+");
		System.out.println("|                                             |");
		System.out.println("|            My Page - ChangeMode             |");
		System.out.println("|                                             |");
		System.out.println("|                                             |");
		System.out.println("|  1. ChangePassword    2. ChangeFirstName    |");
		System.out.println("|                                             |");
		System.out.println("|  3. ChangeLastName    4. ChangePhoneNumber  |");
		System.out.println("|                                             |");
		System.out.println("|  5. ChangeEmail       6. ChangeSex          |");
		System.out.println("|                                             |");
		System.out.println("|  7. ChangeAddress     8. ChangeAge          |");
		System.out.println("|                                             |");
		System.out.println("|  9. Back                                    |");
		System.out.println("|                                             |");
		System.out.println("+---------------------------------------------+");
		System.out.print(">> ");
		switch (sc.nextLine()) {
		case "1":
			changeInformation(1);
			break;
		case "2":
			changeInformation(2);
			break;
		case "3":
			changeInformation(3);
			break;
		case "4":
			changeInformation(4);
			break;
		case "5":
			changeInformation(5);
			break;
		case "6":
			changeInformation(6);
			break;
		case "7":
			changeInformation(7);
			break;
		case "8":
			changeInformation(8);
			break;
		case "9":
			return;
		default:
			System.out.println("Wrong input!!");
			System.exit(1);
		}
	}

	public void deleteAccount() {
		int accountNo = -1;
		
		try {
			String sql = "select accountno from account where accountid ='" + id + "'";
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				accountNo = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			String sql = "delete from membership where AccountNo = " + accountNo;
			stmt.addBatch(sql);
			sql = "delete from account where AccountNo = " + accountNo;
			stmt.addBatch(sql);
			int count[] = stmt.executeBatch();
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("[계정이 삭제되었습니다.]");
	}
	
	public void changeInformation(int cmd) {
		String sql = "";
		switch(cmd) {
		case 1:
			System.out.print("변경할 패스워드[최대 15자] : ");
			String newPassword = sc.nextLine();
			sql = "update account set pwd = '" + newPassword + "' where accountid = '" + id + "'";
			break;
		case 2:
			System.out.print("변경할 First name[최대 15자] : ");
			String newFname = sc.nextLine();
			sql = "update account set fname = '" + newFname + "' where accountid = '" + id + "'";
			break;
		case 3:
			System.out.print("변경할 Last name[최대 15자] : ");
			String newLname = sc.nextLine();
			sql = "update account set lname = '" + newLname + "' where accountid = '" + id + "'";
			break;
		case 4:
			System.out.print("변경할 전화번호[xxx-xxxx-xxxx] : ");
			String newPhone = sc.nextLine();
			sql = "update account set phone = '" + newPhone + "' where accountid = '" + id + "'";
			break;
		case 5:
			System.out.print("변경할 이메일[최대 30자] : ");
			String newEmail = sc.nextLine();
			sql = "update account set email = '" + newEmail + "' where accountid = '" + id + "'";
			break;
		case 6:
			System.out.print("변경할 성별[M or F] : ");
			String newSex = sc.nextLine();
			sql = "update account set sex = '" + newSex + "' where accountid = '" + id + "'";
			break;
		case 7:
			System.out.print("변경할 주소[최대 50자] : ");
			String newAddress = sc.nextLine();
			sql = "update account set address = '" + newAddress + "' where accountid = '" + id + "'";
			break;
		case 8:
			System.out.print("변경할 나이 : ");
			String newAge = sc.nextLine();
			sql = "update account set age = " + newAge + " where accountid = '" + id + "'";
			break;
		case 9:
			return;
		default:
				System.out.println("Wrong input!!");
				System.exit(1);
		}
		try {
			int result = stmt.executeUpdate(sql);
			conn.commit();
			System.out.println("[성공적으로 변경되었습니다.]");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
